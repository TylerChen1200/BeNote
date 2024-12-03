//
//  RegisterViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class RegisterViewController: UIViewController {

    let registerScreenView = RegisterScreenView()
    let childProgressView = ProgressSpinnerViewController()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = registerScreenView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerScreenView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        registerNewAccount()
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error registering!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }
}
