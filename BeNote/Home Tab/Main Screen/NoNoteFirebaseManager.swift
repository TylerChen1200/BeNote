//
//  NoNoteFirebaseManager.swift
//  BeNote
//
//  Created by Jiana Ang on 11/27/24.
//

import UIKit
import FirebaseAuth
import FirebaseCore

extension HomeViewController {
    
    func hasNoteToday() {
        self.showActivityIndicator()
        if let currentUserID = self.defaults.object(forKey: Configs.defaultUID) as! String? {
            // access the user's notes
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Notes)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        self.showErrorAlert("Error fetching user data: \(error)")
                        return
                    }
                    
                    // get the last note in the list of notes
                    if let uwLastNote = querySnapshot?.documents.last {
                        let data = uwLastNote.data()
                        print(data)
                        // first confirm that a date can be extracted from the note
                        if let timestamp = data["timestampCreated"] as? Timestamp {
                            // if the note Dwas posted today, set the variable for the controller
                            let uwDate = timestamp.dateValue()
                            if (Calendar.current.isDateInToday(uwDate)) {
                                self.latestNote = Note(prompt: data["prompt"] as? String ?? "No Prompt",
                                                       creatorDisplayName: data["creatorEmail"] as? String ?? "No Email",
                                                       creatorReply: data["creatorReply"] as? String ?? "",
                                                       location: data["location"] as? String ?? "",
                                                       timestampCreated: uwDate,
                                                       likes: data["likes"] as? [String] ?? [String]()
                                )
                            }
                        } else {
                            print(data)
                            self.showErrorAlert("Error fetching latest note")
                        }
                    }
                    self.hideActivityIndicator()
                    
                    if (self.latestNote == nil) {
                        // no latest note so display the add/edit view
                        self.mainScreen.modalOverlay.isHidden = false
                        self.mainScreen.tableViewNotes.isUserInteractionEnabled = false
                    } else {
                        // update the current views labels with the note info
                        self.mainScreen.modalOverlay.isHidden = true
                        self.mainScreen.tableViewNotes.isUserInteractionEnabled = true
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
