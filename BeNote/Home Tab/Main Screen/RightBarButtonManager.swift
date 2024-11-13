//
//  RightBarButtonManager.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit
import FirebaseAuth

extension HomeViewController{
    func setupRightBarButton(isLoggedin: Bool){
        if isLoggedin{
            //MARK: user is logged in...
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItems = [barIcon, barText]
            
        }else{
            //MARK: not logged in...
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "person.fill.questionmark"),
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Sign in",
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItems = [barIcon, barText]
        }
    }
    
    @objc func onSignInBarButtonTapped(){
        let signInAlert = UIAlertController(
            title: "Sign In / Register",
            message: "Please sign in to continue.",
            preferredStyle: .alert)
        
        //MARK: setting up email textField in the alert...
        signInAlert.addTextField{ textField in
            textField.placeholder = "Enter email"
            textField.contentMode = .center
            textField.keyboardType = .emailAddress
        }
        
        //MARK: setting up password textField in the alert...
        signInAlert.addTextField{ textField in
            textField.placeholder = "Enter password"
            textField.contentMode = .center
            textField.isSecureTextEntry = true
        }
        
        //MARK: Sign In Action...
        let signInAction = UIAlertAction(title: "Sign In", style: .default, handler: {(_) in
            if let email = signInAlert.textFields![0].text,
               let password = signInAlert.textFields![1].text{
                if (email.isEmpty || password.isEmpty) {
                    self.showErrorAlert("Cannot submit empty fields")
                }
                //MARK: sign-in logic for Firebase...
                self.signInToFirebase(email: email, password: password)
            }
        })
        
        //MARK: Register Action...
        let registerAction = UIAlertAction(title: "Register", style: .default, handler: {(_) in
            //MARK: logic to open the register screen...
            let registerViewController = RegisterViewController()
            self.navigationController?.pushViewController(registerViewController, animated: true)
        })
        
        //MARK: action buttons...
        signInAlert.addAction(signInAction)
        signInAlert.addAction(registerAction)
        
        self.present(signInAlert, animated: true, completion: {() in
            //MARK: hide the alerton tap outside...
            signInAlert.view.superview?.isUserInteractionEnabled = true
            signInAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
    }
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
    }

    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
    func signInToFirebase(email: String, password: String){
        self.showActivityIndicator()
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
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
        
        self.hideActivityIndicator()
    }
    
    func showErrorAlert(_ message: String) {
        let errorAlert = UIAlertController(title: "Error signing in!",
                                           message: message,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(errorAlert, animated: true)
    }
}
