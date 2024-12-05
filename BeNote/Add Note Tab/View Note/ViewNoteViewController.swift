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
    let notificationCenter = NotificationCenter.default
    let defaults = UserDefaults.standard

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
        
        // Settings observers
        observeRefresh()
    }
    
    // Highlights labels based on whether the note was done with the daily prompt or freewrite
    func updateLabelsWithNote() {
        if let uwNote = self.latestNote {
            viewNoteScreen.labelPromptReply.text = uwNote.creatorReply
            viewNoteScreen.labelPrompt.text = uwNote.prompt
            viewNoteScreen.labelLocation.text = uwNote.location
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
                viewNoteScreen.labelFreeWrite.textColor = .gray
            }
        }
    }
    
    func showEditButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(onEditButtonTapped)
        )
    }
    
    @objc func onEditButtonTapped() {
        if let note = self.latestNote {
            let addNoteViewController = AddNoteViewController()
            
            // set the other aspects of the note in the screen
            addNoteViewController.addNoteScreen.labelPrompt.text = self.prompt
            if (note.prompt == FirebaseConstants.Freewrite) {
                addNoteViewController.addNoteScreen.switchFreeWrite.setOn(true, animated: true)
                addNoteViewController.updateSwitchUI(true)
            } else {
                addNoteViewController.addNoteScreen.switchFreeWrite.setOn(false, animated: true)
                addNoteViewController.updateSwitchUI(false)
            }
            
            addNoteViewController.addNoteScreen.textFieldPrompt.text = note.creatorReply
            self.navigationController?.pushViewController(addNoteViewController, animated: false)
        } else {
            self.showErrorAlert("Unable to load note. Please try again later.")
        }
    }
    
    // Observing refresh
    func observeRefresh(){
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceived(notification:)),
            name: Configs.notificationRefresh, object: nil
        )
    }
    
    //MARK: handling notifications...
    @objc func notificationReceived(notification: Notification){        
        // Recalls this function to reload the screen since it'll show the right screen
        loadLatestNote()
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }
}
