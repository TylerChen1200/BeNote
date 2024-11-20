//
//  ViewNoteViewController.swift
//  BeNote
//
//  Created by MAD on 11/19/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewNoteViewController: UIViewController {
    
    let viewNoteScreen = ViewNoteScreenView()
    let db = Firestore.firestore()
    var latestNote: Note? = nil
    let childProgressView = ProgressSpinnerViewController()
    var prompt: String = FirebaseConstants.DefaultPrompt

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
    
    func updateLabelsWithNote() {
        if let uwNote = self.latestNote {
            viewNoteScreen.labelPromptReply.text = uwNote.creatorReply
            viewNoteScreen.labelPrompt.text = uwNote.prompt
            
            if (uwNote.prompt == FirebaseConstants.Freewrite) {
                viewNoteScreen.labelPrompt.isHidden = true
                viewNoteScreen.switchFreeWrite.isOn = true
                viewNoteScreen.labelFreeWrite.textColor = .black
            } else {
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
