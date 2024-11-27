//
//  LoginViewController.swift
//  BeNote
//
//  Created by Jiana Ang on 11/21/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    var delegate: HomeViewController?
    let childProgressView = ProgressSpinnerViewController()
    
    init(homeViewController: HomeViewController) {
        self.delegate = homeViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loginView.loginButton.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(onSignUpTapped), for: .touchUpInside)
    }
    
    @objc func onLoginTapped() {
        if let email = loginView.emailTextField.text,
           let password = loginView.passwordTextField.text{
            if (email.isEmpty || password.isEmpty) {
                self.showErrorAlert("Cannot submit empty fields")
            }
            //MARK: sign-in logic for Firebase...
            self.signInToFirebase(email: email, password: password)
        }
    }
    
    @objc func onSignUpTapped() {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error signing in!", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }
    
    func signInToFirebase(email: String, password: String){
        self.showActivityIndicator()
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            self.hideActivityIndicator()

            if error == nil{
                //MARK: user authenticated...
                self.delegate?.setupRightBarButton(isLoggedin: true)
                self.dismiss(animated: true)
            }else{
                //MARK: alert that no user found or password wrong...
                var message: String = "Error occurred while signing in. Please try again."
                if let nsError = error as? NSError,
                   let code = AuthErrorCode(rawValue: nsError.code) {
                    print(nsError.code)
                    switch code {
                    case AuthErrorCode.wrongPassword :
                        message = "Incorrect password"
                        break
                    case AuthErrorCode.userNotFound :
                        message = "No account with that email. Please register"
                        break
                    case AuthErrorCode.invalidEmail:
                        message = "Invalid email formatting"
                        break
                    default:
                        break
                    }
                }
                
                self.showErrorAlert(message)
            }
        })
    }
    
}
