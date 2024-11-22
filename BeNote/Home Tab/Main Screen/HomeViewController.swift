//
//  ViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    let mainScreen = MainScreenView()
    var notesList = [Note]()
    let childProgressView = ProgressSpinnerViewController()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = mainScreen
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewNotes.delegate = self
        mainScreen.tableViewNotes.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewNotes.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                
                let loginVC = LoginViewController(homeViewController: self)
                loginVC.delegate = self
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.modalPresentationStyle = .fullScreen
                navigationController.isModalInPresentation = true
                self.present(navigationController, animated: true)

                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to send your note of the day!"
                self.mainScreen.floatingButtonAddContact.isEnabled = false
                self.mainScreen.floatingButtonAddContact.isHidden = true
                
//                self.setupRightBarButton(isLoggedin: false)
                self.disableTabs()
                
                //MARK: Reset tableView...
               self.notesList.removeAll()
               self.mainScreen.tableViewNotes.reloadData()
            } else {
                //MARK: the user is signed in...
                self.setupRightBarButton(isLoggedin: true)
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddContact.isEnabled = true
                self.mainScreen.floatingButtonAddContact.isHidden = false
                
//                self.setupRightBarButton(isLoggedin: true)
                self.enableTabs()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "BeNote"
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonAddContact)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
}

