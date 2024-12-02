//
//  ViewNoteViewController.swift
//  BeNote
//
//  Created by MAD on 11/19/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

// Entrance for the add note tab
// allows the user to
// 1. view their note of the day
// 2. edit their note (coming soon)
// 3. add a new note if one doesn't already (mandatory - screen will show automatically)
class ViewNoteViewController: UIViewController {
    
    let viewNoteScreen = ViewNoteScreenView()
    let db = Firestore.firestore()
    var latestNote: Note? = nil
    let childProgressView = ProgressSpinnerViewController()
    var prompt: String = FirebaseConstants.DefaultPrompt
    let today: String = todaysDate()

    // every time the view is to show, check if there is a note
    // if not, show the AddNoteViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadLatestNote()
    }
    
    override func loadView() {
        view = viewNoteScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Todays Note"
    }
    
    // Highlights labels based on whether the note was done with the daily prompt or freewrite
    func updateLabelsWithNote() {
        if let uwNote = self.latestNote {
            viewNoteScreen.labelPromptReply.text = uwNote.creatorReply
            viewNoteScreen.labelPrompt.text = uwNote.prompt
            let contentHeight = viewNoteScreen.labelPromptReply.sizeThatFits(CGSize(width: viewNoteScreen.labelPromptReply.frame.width, height: .infinity)).height
            viewNoteScreen.labelPromptReply.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
            
            if (uwNote.prompt == FirebaseConstants.Freewrite) {
                // Prompt was freewrite - highlight those elements
                viewNoteScreen.labelPrompt.isHidden = true
                viewNoteScreen.switchFreeWrite.isOn = true
                viewNoteScreen.labelFreeWrite.textColor = .black
            } else {
                // Prompt was daily prompt
                viewNoteScreen.labelPrompt.isHidden = false
                viewNoteScreen.switchFreeWrite.isOn = false
                viewNoteScreen.labelFreeWrite.textColor = .lightGray
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
