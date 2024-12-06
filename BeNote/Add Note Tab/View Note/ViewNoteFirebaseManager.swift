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
    
    // Loads the most recent note from Firebase
    // If there is no note from the current day
    // 1. get the daily prompt
    // 2. Push the addNoteViewController to the navigation controller
    func loadLatestNote() {
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
                        self.loadTodaysPrompt()
                    } else {
                        // update the current views labels with the note info
                        self.updateLabelsWithNote()
                    }
                }
        }
    }
    
    // load the prompt from the day and pass it to the AddNoteViewController
    func loadTodaysPrompt() {
        // Access the notes from the current day to check for a daily prompt
        db.collection(FirebaseConstants.Notes)
            .document(FirebaseConstants.Notes)
            .collection(self.today)
            .getDocuments { (querySnapshot, error) in
                let currPrompt = querySnapshot?.documents
                    .first { $0.documentID == FirebaseConstants.DailyPrompt }
                
                if let uwCurrPrompt = currPrompt {
                    // there is an existing document for the daily prompt
                    // load the existing prompt
                    let data = uwCurrPrompt.data()
                    self.prompt = data[FirebaseConstants.DailyPrompt] as! String
                    self.pushAddNoteScreen()
                } else {
                    // If there is no existing prompt, generate one
                    self.generateNewPrompt()
                }
            }
    }
    
    // Generate a random prompt for all BeNote users to reply to for the day
    func generateNewPrompt() {
        // Access the notes documents to get the list of prompts
        db.collection(FirebaseConstants.Notes).getDocuments { (querySnapshot, error) in
            if let _ = error {
                self.showErrorAlert("Error fetching user data. Try again")
                return
            }
            
            // generate a new prompt
            let promptData = querySnapshot?.documents
                .first { $0.documentID == FirebaseConstants.Prompts }
            
            if let uwPromptData = promptData {
                // get all the prompts and randomly select one
                let data = uwPromptData.data()
                let allPrompts = Prompts(prompts: data[FirebaseConstants.Prompts] as? [String] ?? [String]())
                let randomIndex = Int.random(in: 0..<allPrompts.prompts.count)
                self.prompt = allPrompts.prompts[randomIndex]
                
                // add that prompt to the notes collection, under the current day
                self.db.collection(FirebaseConstants.Notes)
                    .document(FirebaseConstants.Notes)
                    .collection(self.today)
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
                
                // push the AddNoteViewController with the updated prompt
                self.pushAddNoteScreen()
            }
        }
    }
    
    func pushAddNoteScreen() {
        let addNoteViewController = AddNoteViewController()
        addNoteViewController.addNoteScreen.labelPrompt.text = self.prompt
        self.navigationController?.pushViewController(addNoteViewController, animated: false)
    }
}
