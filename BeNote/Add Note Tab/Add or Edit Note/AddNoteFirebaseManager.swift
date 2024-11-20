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
    func sendNoteToFirebase() {
        self.showActivityIndicator()
         
        if let currentUserID = Auth.auth().currentUser?.uid {
            // save note to notes collection
            db.collection(FirebaseConstants.Notes)
                .document(FirebaseConstants.Notes)
                .collection(self.today)
                .document(currentUserID)
                .setData([
                    "prompt": freeWrite ? "Freewrite" : self.addNoteScreen.labelPrompt.text as Any,
                    "creatorDisplayName": Auth.auth().currentUser?.displayName as Any,
                    "creatorReply": addNoteScreen.textFieldPrompt.text as Any,
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
                    "creatorEmail": Auth.auth().currentUser?.email as Any,
                    "creatorReply": addNoteScreen.textFieldPrompt.text as Any,
                    "timestampCreated": Timestamp(date: Date()),
                        ]) { error in
                            if let error = error {
                                print("Error saving note data: \(error)")
                            } else {
                                print("Note saved successfully.")
                            }
                        }
        }
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.hideActivityIndicator()
        }
    }
}
