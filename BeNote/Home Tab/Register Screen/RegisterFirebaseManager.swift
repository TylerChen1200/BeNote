//
//  RegisterFirebaseManager.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount(){
        self.showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = registerScreenView.textFieldName.text,
           let email = registerScreenView.textFieldEmail.text,
           let password = registerScreenView.textFieldPassword.text{
            //Validations....
            if (name.isEmpty || email.isEmpty || password.isEmpty) {
                self.showErrorAlert("Cannot submit empty fields")
            }
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    self.addToUserDB(name: name, email: email)
                }else{
                    //MARK: there is a error creating the user...
                    var message: String = "Error occurred while signing in. Please try again."
                    if let nsError = error as? NSError,
                       let code = AuthErrorCode(rawValue: nsError.code) {
                        print(nsError.code)
                        switch code {
                            case AuthErrorCode.invalidEmail:
                                message = "Invalid email formatting"
                                break
                            case AuthErrorCode.weakPassword:
                                message = "Weak password. Please use a new one"
                            case AuthErrorCode.emailAlreadyInUse:
                                message = "Account with email exists. Please sign in."
                            default:
                               break
                        }
                    }
                    
                    self.hideActivityIndicator()
                    self.showErrorAlert(message)
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.hideActivityIndicator()
                
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func addToUserDB(name: String, email: String) {
        let db = Firestore.firestore()
        db.collection(FirebaseConstants.Users).document(Auth.auth().currentUser!.uid).setData([
            "name": name,
            "email": email,
            "id": Auth.auth().currentUser!.uid,
                ]) { error in
                    if let error = error {
                        print("Error saving user data: \(error)")
                    } else {
                        print("User data saved successfully.")
                    }
                }
    }
}
