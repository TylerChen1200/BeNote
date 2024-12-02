//
//  AddNoteViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit
import FirebaseFirestore

// Controller to handle adding and editing a new note for the user
// A new note will be added once each day, resetting at UTC 0 midnight
class AddNoteViewController: UIViewController, UITextViewDelegate {

    let addNoteScreen = AddNoteScreenView()
    let db = Firestore.firestore()
    var freeWrite = false
    let childProgressView = ProgressSpinnerViewController()
    let today = todaysDate()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = addNoteScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Note"
        
        // Do any additional setup after loading the view.
        hideKeyboardOnTapOutside()
        addNoteScreen.textFieldPrompt.delegate = self
        
        addNoteScreen.switchFreeWrite.addTarget(self, action: #selector(onSwitchFlipped(_:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Submit Note",
            style: .plain,
            target: self,
            action: #selector(onSubmitButtonTapped)
        )
        
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // handles the UISwitch element being flipped
    @objc func onSwitchFlipped(_ sender: UISwitch) {
        // 1. bold the Freewrite label
        // 2. Change the controller variable to know what to send to firebase
        if (sender.isOn) {
            // code for switch being on
            addNoteScreen.labelFreeWrite.font = UIFont.boldSystemFont(ofSize: 20)
            addNoteScreen.labelFreeWrite.textColor = .black
            addNoteScreen.labelPrompt.textColor = .lightGray
            self.freeWrite = true
        } else {
            // code for switch being off
            addNoteScreen.labelFreeWrite.font = UIFont.systemFont(ofSize: 20)
            addNoteScreen.labelFreeWrite.textColor = .lightGray
            addNoteScreen.labelPrompt.textColor = .black
            self.freeWrite = false
        }
    }
    
    // Handles the submit navbar button being tapped
    @objc func onSubmitButtonTapped() {
        if let uwNoteText = addNoteScreen.textFieldPrompt.text {
            if (uwNoteText.isEmpty) {
                self.showErrorAlert("Fields cannot be empty")
            } else {
                self.sendNoteToFirebase()
            }
        }
    }
    
    //MARK: hide keyboard logic...
    func hideKeyboardOnTapOutside(){
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }
}
