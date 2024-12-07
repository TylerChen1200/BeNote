//
//  ViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    var notesList = [Note]()
    let db = Firestore.firestore()
    var latestNote: Note? = nil
    let childProgressView = ProgressSpinnerViewController()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let notificationCenter = NotificationCenter.default
    let today: String = todaysDate()
    let defaults = UserDefaults.standard
    var prevColor: UIColor = UIColor()
    
    override func loadView() {
        view = mainScreen
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewNotes.delegate = self
        mainScreen.tableViewNotes.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewNotes.separatorStyle = .none
        
        self.getFriendsNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                
                let loginVC = LoginViewController(homeViewController: self)
                loginVC.delegate = self
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.modalPresentationStyle = .fullScreen
                navigationController.isModalInPresentation = true
                self.present(navigationController, animated: false)
                
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to send your note of the day!"
                
                self.disableTabs()
                
                //MARK: Reset tableView...
                self.notesList.removeAll()
                self.mainScreen.tableViewNotes.reloadData()
            } else {
                //MARK: the user is signed in...
                self.setupRightBarButton(isLoggedin: true)
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                
                self.enableTabs()
            }
        }
        hasNoteToday()
        mainScreen.tableViewNotes.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "BeNote"
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewNotes.delegate = self
        mainScreen.tableViewNotes.dataSource = self
        
        // Settings observers
        observeRefresh()
        logo()
        
        mainScreen.addNoteButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        mainScreen.buttonRefresh.addTarget(self, action: #selector(refreshButton), for: .touchUpInside)
    }
    
    @objc func addNote() {
        // Navigate to the second tab
        tabBarController?.selectedIndex = 1
    }
    
    @objc func refreshButton() {
        // Refresh the tab views
        self.notificationCenter.post(
            name: Configs.notificationRefresh,
            object: nil
        )
        
        mainScreen.tableViewNotes.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func getFriendsNotes() {
        if let currentUserID = self.defaults.object(forKey: Configs.defaultUID) as! String? {
            // Initialize empty array for all notes
            self.notesList = []
            
            // Continue with fetching friends' notes
            self.fetchFriendsNotes(currentUserID: currentUserID)
        }
    }
    
    private func fetchFriendsNotes(currentUserID: String) {
        self.showActivityIndicator()
        db.collection(FirebaseConstants.Users)
            .document(currentUserID)
            .collection(FirebaseConstants.Friends)
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    self?.showErrorAlert("Error fetching user data: \(error)")
                    return
                }
                
                let friendsArray = querySnapshot?.documents
                    .map { document in
                        return document.documentID
                    } ?? []
                
                self?.db.collection(FirebaseConstants.Notes)
                    .document(FirebaseConstants.Notes)
                    .collection(self?.today ?? "")
                    .getDocuments { [weak self] (querySnapshot, error) in
                        if let error = error {
                            self?.showErrorAlert("Error fetching user data: \(error)")
                            return
                        }
                        
                        // Explicitly type friendNotes as [Note]
                        let friendNotes: [Note] = querySnapshot?.documents
                            .filter { document in
                                let title = document.documentID
                                return friendsArray.contains(title)
                            }
                            .map { document in
                                let data = document.data()
                                let timestamp = data["timestampCreated"] as? Timestamp
                                let uwDate = timestamp?.dateValue() ?? Date()
                                
                                return Note(
                                    prompt: data["prompt"] as? String ?? "No Prompt",
                                    creatorDisplayName: data["creatorDisplayName"] as? String ?? "No Display Name",
                                    creatorReply: data["creatorReply"] as? String ?? "No Reply",
                                    location: data["location"] as? String ?? "No Location",
                                    timestampCreated: uwDate,
                                    likes: data["likes"] as? [String] ?? [String](),
                                    creatorID: document.documentID
                                )
                            } ?? []
                        
                        // Update the array concatenation
                        self?.notesList += friendNotes
                        
                        // attempt to sort the notes by latest timestamp
                        let sortedNotes = self?.notesList.sorted{a, b in
                            a.timestampCreated > b.timestampCreated
                        }
                        
                        if let uwSortedNotes = sortedNotes {
                            self?.notesList = uwSortedNotes
                            
                            // hide/show the placeholder if needed
                            if (uwSortedNotes.count == 0) {
                                self?.mainScreen.labelPlaceholder.isHidden = false
                            } else {
                                self?.mainScreen.labelPlaceholder.isHidden = true
                            }
                        }
                        
                        self?.mainScreen.tableViewNotes.reloadData()
                        
                        self?.db.collection(FirebaseConstants.Notes)
                            .document(FirebaseConstants.Notes)
                            .collection(self?.today ?? "")
                            .getDocuments { [weak self] (querySnapshot, error) in
                                
                                let dailyPromptData = querySnapshot?.documents
                                    .first{ $0.documentID == FirebaseConstants.DailyPrompt }
                                    
                                if let uwDailyPromptData = dailyPromptData {
                                    let dailyPrompt = uwDailyPromptData.data()[FirebaseConstants.DailyPrompt] as? String ?? FirebaseConstants.DefaultPrompt
                                    
                                    self?.mainScreen.labelPrompt.text = dailyPrompt
                                }
                                
                            }
                    }
            }
        self.hideActivityIndicator()
    }
}

extension HomeViewController {
    func fetchAndSetProfilePicture(for userID: String, imageView: UIImageView) {
        self.showActivityIndicator()
        db.collection(FirebaseConstants.Users)
            .document(userID)
            .getDocument { document, error in
                if let error = error {
                    print("Error fetching profile picture: \(error)")
                    return
                }
                
                // Check for the URL in Firestore
                if let profilePictureURL = document?.data()?["profilePictureURL"] as? String,
                   let url = URL(string: profilePictureURL) {
                    
                    // Create a URLSession task to download the image
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let error = error {
                            print("Error downloading profile picture: \(error)")
                            return
                        }
                        
                        if let data = data,
                           let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                imageView.image = image
                                // Make the image circular
                                imageView.layer.cornerRadius = imageView.frame.size.width / 2
                                imageView.clipsToBounds = true
                            }
                        }
                    }.resume()
                }
            }
        self.hideActivityIndicator()
    }
}
