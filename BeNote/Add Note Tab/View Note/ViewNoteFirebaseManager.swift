//
//  ViewNoteFirebaseManager.swift
//  BeNote
//
//  Created by MAD on 11/19/24.
//

import UIKit
import FirebaseAuth
import FirebaseCore

extension ViewNoteViewController {
    func loadLatestNote() {
        self.showActivityIndicator()
        if let currentUserID = Auth.auth().currentUser?.uid {
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .collection(FirebaseConstants.Notes)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        self.showErrorAlert("Error fetching user data: \(error)")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        // get the last note in the list of notes
                        if let uwLastNote = querySnapshot?.documents.last {
                            let data = uwLastNote.data()
                            print(data)
                            // first confirm that a date can be extracted from the note
                            if let timestamp = data["timestampCreated"] as? Timestamp {
                                // if the note was posted today, set the variable for the controller
                                let uwDate = timestamp.dateValue()
                                if (Calendar.current.isDateInToday(uwDate)) {
                                    self.latestNote = Note(prompt: data["prompt"] as? String ?? "No Prompt",
                                                           creatorDisplayName: data["creatorEmail"] as? String ?? "No Email",
                                                           creatorReply: data["creatorReply"] as? String ?? "",
                                                           timestampCreated: uwDate
                                    )
                                }
                            } else {
                                print(data)
                                self.showErrorAlert("Error fetching latest note")
                            }
                        }
                        self.hideActivityIndicator()
                        
                        if (self.latestNote == nil) {
                            // no latest note so display the edit view
                            self.loadTodaysPrompt()
                        } else {
                            // update the current views labels with the note info
                            self.updateLabelsWithNote()
                        }
                    }
                }
        }
    }
    
    func loadTodaysPrompt() {
        db.collection(FirebaseConstants.Notes)
            .document(FirebaseConstants.Notes)
            .collection(todaysDate())
            .getDocuments { (querySnapshot, error) in
                let currPrompt = querySnapshot?.documents
                    .first { $0.documentID == FirebaseConstants.DailyPrompt }
                
                if let uwCurrPrompt = currPrompt {
                    // there is an existing document for the daily prompt
                    // load the existing prompt
                    let data = uwCurrPrompt.data()
                    self.prompt = data[FirebaseConstants.DailyPrompt] as! String
                    let addNoteViewController = AddNoteViewController()
                    addNoteViewController.addNoteScreen.labelPrompt.text = self.prompt
                    self.navigationController?.pushViewController(addNoteViewController, animated: false)
                } else {
                    self.generateNewPrompt()
                }
            }
    }
    
    func generateNewPrompt() {
        db.collection(FirebaseConstants.Notes).getDocuments { (querySnapshot, error) in
            if let _ = error {
                self.showErrorAlert("Error fetching user data. Try again")
                return
            }
            
            // generate a new prompt
            let promptData = querySnapshot?.documents
                .first { $0.documentID == FirebaseConstants.Prompts }
            
            if let uwPromptData = promptData {
                let data = uwPromptData.data()
                let allPrompts = Prompts(prompts: data[FirebaseConstants.Prompts] as? [String] ?? [String]())
                let randomIndex = Int.random(in: 0..<allPrompts.prompts.count)
                self.prompt = allPrompts.prompts[randomIndex]
                
                self.db.collection(FirebaseConstants.Notes)
                    .document(FirebaseConstants.Notes)
                    .collection(todaysDate())
                    .document(FirebaseConstants.DailyPrompt)
                    .setData([
                        FirebaseConstants.DailyPrompt: self.prompt
                    ]) { error in
                        if let error = error {
                            print("Error saving prompt data: \(error)")
                        } else {
                            print("Prompt data saved successfully.")
                        }
                    }
                
                let addNoteViewController = AddNoteViewController()
                addNoteViewController.addNoteScreen.labelPrompt.text = self.prompt
                self.navigationController?.pushViewController(addNoteViewController, animated: false)
            }
        }
    }
}
