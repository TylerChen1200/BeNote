//
//  ManageFriendsViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ManageFriendsViewController: UIViewController {
    
    let friendScreen = FriendScreenView()
    let db = Firestore.firestore()
    
    //MARK: list to display the contact names in the TableView...
    var friendsArray = [User]()
    
    override func loadView() {
        view = friendScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: setting the delegate and data source...
        friendScreen.tableViewFriends.dataSource = self
        friendScreen.tableViewFriends.delegate = self
        
        //get all friends names when the screen loads...
        getAllFriends()
        
        friendScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
    }
    
    func getAllFriends() {
        if let currentUserID = Auth.auth().currentUser?.uid {
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Friends)
                .getDocuments { (querySnapshot, error) in
                if let error = error {
                    self.showErrorAlert("Error fetching user data: \(error)")
                    return
                }
                
                // Filter out the current user and then map the documents to User objects
                self.friendsArray = querySnapshot?.documents
                    .map { document in
                        let data = document.data()
                        return User(name: data["name"] as? String ?? "No Name",
                                    email: data["email"] as? String ?? "No Email",
                                    _id: data["id"] as? String ?? "No ID")
                    } ?? []
                print("All users: \(self.friendsArray)")
                DispatchQueue.main.async {
                    self.friendScreen.tableViewFriends.reloadData()
                    print("successfully fetched friend data")
                }
            }
        }
    }
    
    @objc func onButtonAddTapped() {
        if let emailText = friendScreen.textFieldAddFriend.text {
            // validate email entered
            if (emailText.isEmpty || !validateEmail(emailText)) {
                showErrorAlert("Please enter a valid email")
            } else {
                // Step 1: Search users for a matching email
                self.findUserWithEmail(email: emailText)
            }
        }
    }
    
    func deleteFriend(id: String) {
        if let currentUserID = Auth.auth().currentUser?.uid {
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Friends)
                .document(id).delete() {
                    error in
                        if let error = error {
                            print("Error removing friend: \(error)")
                        } else {
                            print("Friend removed successfully.")
                            // Step 3: Refresh view
                            self.getAllFriends()
                        }
                    }
        }
    }
    
    func findUserWithEmail(email: String) {
        var newFriend: User?
        
        let currentUserID = Auth.auth().currentUser?.uid
        
        db.collection(FirebaseConstants.Users).getDocuments { (querySnapshot, error) in
            if let error = error {
                self.showErrorAlert("Error fetching user data. Try again")
                return
            }
            
            // find user with the given email
            newFriend = querySnapshot?.documents
                .filter { $0.documentID != currentUserID }
                .first { $0.data()["email"] as! String == email }
                .map { document in
                    let data = document.data()
                    return User(name: data["name"] as? String ?? "No Name",
                                email: data["email"] as? String ?? "No Email",
                                _id: data["id"] as? String ?? "No ID")
                } ?? nil
            
            DispatchQueue.main.async {
                if let uwFriend = newFriend {
                    print("successfully found friend data")
                    
                    // Step 2: Add friend info to the current users friends collection
                    self.addFriendToCurrentUser(friend: uwFriend)
                } else {
                    self.showErrorAlert("Cannot find friend with that email")
                    return
                }
            }
        }
    }
    
    func addFriendToCurrentUser(friend: User) {
        if let currentUserID = Auth.auth().currentUser?.uid {
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Friends)
                .document(friend._id).setData([
                    "name": friend.name,
                    "email": friend.email,
                    "id": friend._id,
                ]) { error in
                    if let error = error {
                        print("Error saving user data: \(error)")
                    } else {
                        print("User data saved successfully.")
                        // Step 3: Refresh view
                        self.getAllFriends()
                        self.clearAddViewFields()
                    }
                }
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        // code from stack overflow linked in assignment description
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailPred.evaluate(with: email)
        return result
    }
    
    func clearAddViewFields(){
        friendScreen.textFieldAddFriend.text = ""
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }

}
