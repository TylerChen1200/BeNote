//
//  ProfileViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileScreenView()
    let db = Firestore.firestore()
    var notesHistory = [Note]()
    let notificationCenter = NotificationCenter.default
    let defaults = UserDefaults.standard
    
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(editProfileTapped)
        )
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        profileScreen.tableViewNotesHistory.delegate = self
        profileScreen.tableViewNotesHistory.dataSource = self
        
        self.fetchProfileData()
        self.fetchNotesData()
        self.fetchProfilePicture()
        
        observeRefresh()
    }
    
    
    
    func fetchProfileData() {
        if let currentUserEmail = self.defaults.object(forKey: Configs.defaultEmail) as! String?,
           let currentUserName = self.defaults.object(forKey: Configs.defaultName) as! String? {
            self.profileScreen.labelName.text = "Name: \(currentUserName)"
            self.profileScreen.labelEmail.text = "Email: \(currentUserEmail)"
        }
        
    }
    
    func fetchNotesData() {
        if let currentUserID = self.defaults.object(forKey: Configs.defaultUID) as! String? {
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Notes)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        self.showErrorAlert("Error fetching user data: \(error)")
                        return
                    }
                    // get number of notes written
                    let numberOfNotes = querySnapshot?.documents.count ?? 0
                    self.profileScreen.labelNotesWritten.text = "\(numberOfNotes) notes written"
                    
                    // get the history of the notes
                    self.notesHistory = querySnapshot?.documents
                        .map {document in
                            let data = document.data()
                            let timestamp = data["timestampCreated"] as? Timestamp
                            let uwDate = timestamp?.dateValue() ?? Date()
                            
                            return Note(prompt: data["prompt"] as? String ?? "",
                                        creatorDisplayName: data["creatorDisplayName"] as? String ?? "No Email",
                                        creatorReply: data["creatorReply"] as? String ?? "", location: data["location"] as? String ?? "",
                                        timestampCreated: uwDate)
                        }
                        .reversed()
                    ?? [Note]()
                    
                    print(self.notesHistory)
                    self.profileScreen.tableViewNotesHistory.reloadData()
                }
        }
    }
    
    func observeRefresh(){
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceived(notification:)),
            name: Configs.notificationRefresh, object: nil
        )
    }
    
    @objc func notificationReceived(notification: Notification) {
        self.fetchProfileData()
        self.fetchNotesData()
        self.fetchProfilePicture()  
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }
    @objc func editProfileTapped() {
        let editProfileVC = EditProfileViewController()
        let navController = UINavigationController(rootViewController: editProfileVC)
        present(navController, animated: true)
    }
    
    func fetchProfilePicture() {
        guard let currentUserID = self.defaults.object(forKey: Configs.defaultUID) as? String else {
            return
        }
        
        // Set a default profile image or placeholder
        self.profileScreen.imageViewProfile.image = UIImage(systemName: "person.circle.fill")
        
        db.collection(FirebaseConstants.Users)
            .document(currentUserID)
            .getDocument { [weak self] document, error in
                if let error = error {
                    self?.showErrorAlert("Error fetching profile picture: \(error.localizedDescription)")
                    return
                }
                
                // Check for the URL in Firestore
                if let profilePictureURL = document?.data()?["profilePictureURL"] as? String,
                   let url = URL(string: profilePictureURL) {
                    
                    // Create a URLSession task to download the image
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let error = error {
                            DispatchQueue.main.async {
                                self?.showErrorAlert("Error downloading profile picture: \(error.localizedDescription)")
                            }
                            return
                        }
                        
                        if let data = data,
                           let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.profileScreen.imageViewProfile.image = image
                            }
                        }
                    }.resume()
                }
            }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notesHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewProfileID, for: indexPath) as! ProfileTableViewCell
        cell.labelPrompt.text = notesHistory[indexPath.row].prompt
        cell.labelReply.text = notesHistory[indexPath.row].creatorReply
        cell.labelTimestampCreated.text = formatTimestamp(notesHistory[indexPath.row].timestampCreated)
        cell.labelLocation.text = notesHistory[indexPath.row].location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteFullVC = NoteFullViewController()
        noteFullVC.note = self.notesHistory[indexPath.row]
        self.navigationController?.pushViewController(noteFullVC, animated: true)
    }
    
    func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a" // Month day year, and time without leading zeros (12-hour format)
        return formatter.string(from: timestamp)
    }
    
}
