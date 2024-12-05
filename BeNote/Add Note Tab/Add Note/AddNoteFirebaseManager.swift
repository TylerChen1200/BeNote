//
//  AddNoteFirebaseManager.swift
//  BeNote
//
//  Created by MAD on 11/19/24.
//

import UIKit
import FirebaseAuth
import FirebaseCore

extension AddNoteViewController {
    // handles sending the written note to Firestore
    // save it both in the notes folder and the user folder to easily populate home and history screens
    func sendNoteToFirebase() {
        self.showActivityIndicator()
        
        if let currentUserID = self.defaults.object(forKey: Configs.defaultUID) as! String? {
            // save note to notes collection
            db.collection(FirebaseConstants.Notes)
                .document(FirebaseConstants.Notes)
                .collection(self.today)
                .document(currentUserID)
                .setData([
                    "prompt": freeWrite ? "Freewrite" : self.addNoteScreen.labelPrompt.text as Any,
                    "creatorDisplayName": self.defaults.object(forKey: Configs.defaultName) as Any,
                    "creatorReply": addNoteScreen.textFieldPrompt.text as Any,
                    "location" : self.location as Any,
                    "timestampCreated": Timestamp(date: Date()),
                        ]) { error in
                            if let error = error {
                                print("Error saving note data: \(error)")
                            } else {
                                print("Note saved successfully.")
                            }
                        }
            
            // save note to user collection
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Notes)
                .document(self.today)
                .setData([
                    "prompt": freeWrite ? "Freewrite" : self.addNoteScreen.labelPrompt.text as Any,
                    "creatorDisplayName": self.defaults.object(forKey: Configs.defaultEmail) as Any,
                    "creatorReply": addNoteScreen.textFieldPrompt.text as Any,
                    "location" : self.location as Any,
                    "timestampCreated": Timestamp(date: Date()),
                        ]) { error in
                            if let error = error {
                                print("Error saving note data: \(error)")
                            } else {
                                print("Note saved successfully.")
                            }
                        }
            
            // Refresh the tab views
            self.notificationCenter.post(
                name: Configs.notificationRefresh,
                object: nil
            )
            // go back to viewNote screen
            self.navigationController?.popViewController(animated: true)
            self.hideActivityIndicator()
        }
    }
}
