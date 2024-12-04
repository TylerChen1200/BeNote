//
//  ProfileViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileScreenView()
    let db = Firestore.firestore()
    var notesHistory = [Note]()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: patching table view delegate and data source...
        profileScreen.tableViewNotesHistory.delegate = self
        profileScreen.tableViewNotesHistory.dataSource = self
        self.fetchProfileData()
        self.fetchNotesData()
        
        // Setting observers
        observeRefresh()
    }
    
    
    func fetchProfileData() {
        if let currentUserEmail = Auth.auth().currentUser?.email,
           let currentUserName = Auth.auth().currentUser?.displayName {
            self.profileScreen.labelName.text = "\(currentUserName)"
            self.profileScreen.labelEmail.text = "Email: \(currentUserEmail)"
        }
        
    }
    
    func fetchNotesData() {
        if let currentUserID = Auth.auth().currentUser?.uid {
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
    
    // Observing refresh
    func observeRefresh(){
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceived(notification:)),
            name: Configs.notificationRefresh, object: nil
        )
    }
    
    // Refreshes the profile content of this screen
    @objc func notificationReceived(notification: Notification){
        self.fetchProfileData()
        self.fetchNotesData()
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a" // Month day year, and time without leading zeros (12-hour format)
        return formatter.string(from: timestamp)
    }
    
}
