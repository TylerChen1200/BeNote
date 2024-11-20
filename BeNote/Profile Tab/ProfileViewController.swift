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
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true


        self.fetchProfileData()
        self.fetchNotesData()
    }
    

    func fetchProfileData() {
        if let currentUserEmail = Auth.auth().currentUser?.email,
           let currentUserName = Auth.auth().currentUser?.displayName {
            self.profileScreen.labelName.text = "Name: \(currentUserName)"
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
                    
                    let numberOfNotes = querySnapshot?.documents.count ?? 0
                    
                    DispatchQueue.main.async {
                        self.profileScreen.labelNotesWritten.text = "\(numberOfNotes) notes written"
                    }
                }
        }
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }

}
