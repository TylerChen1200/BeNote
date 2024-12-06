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
    }
    
    @objc func addNote() {
        // Navigate to the second tab
        tabBarController?.selectedIndex = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func getFriendsNotes() {
        if let currentUserID = self.defaults.object(forKey: Configs.defaultUID) as! String? {
            
            var friendsArray = [String]()
            
            // get the users friends
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Friends)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        self.showErrorAlert("Error fetching user data: \(error)")
                        return
                    }
                    
                    // Filter out the current user and then map the documents to User objects
                    friendsArray = querySnapshot?.documents
                        .map { document in
                            return document.documentID
                        } ?? []
                    
                    // save note to notes collection
                    self.db.collection(FirebaseConstants.Notes)
                        .document(FirebaseConstants.Notes)
                        .collection(self.today)
                        .getDocuments { (querySnapshot, error) in
                            if let error = error {
                                self.showErrorAlert("Error fetching user data: \(error)")
                                return
                            }
                            
                            // Filter out the current user and then map the documents to User objects
                            self.notesList = querySnapshot?.documents
                                .filter { document in
                                    let title = document.documentID
                                    return friendsArray.contains(title)
                                }
                                .map {document in
                                    let data = document.data()
                                    let timestamp = data["timestampCreated"] as? Timestamp
                                    let uwDate = timestamp?.dateValue() ?? Date()
                                    
                                    return Note(prompt: data["prompt"] as? String ?? "No Prompt",
                                                creatorDisplayName: data["creatorDisplayName"] as? String ?? "No Display Name",
                                                creatorReply: data["creatorReply"] as? String ?? "No Reply",
                                                location: data["location"] as? String ?? "No Location",
                                                timestampCreated: uwDate)
                                }
                            ?? [Note]()
                            
                            let dailyPrompt = self.notesList.first {
                                $0.prompt != FirebaseConstants.Freewrite
                            }
                            
                            if let uwDailyPrompt = dailyPrompt {
                                self.mainScreen.labelPrompt.text = uwDailyPrompt.prompt
                            } else {
                                self.mainScreen.labelPrompt.text = FirebaseConstants.DefaultPrompt
                            }
                            
                            print("All Notes: \(self.notesList)")
                            
                            self.mainScreen.tableViewNotes.reloadData()
                        }
                }
        }
    }
}
