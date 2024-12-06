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
        //MARK: create a Firebase user with email and password...
        if let name = registerScreenView.textFieldName.text,
           let email = registerScreenView.textFieldEmail.text?.lowercased(),
           let password = registerScreenView.textFieldPassword.text,
           let passwordVal = registerScreenView.textFieldPasswordVal.text{
            //Validations....
            if (name.isEmpty || email.isEmpty || password.isEmpty || passwordVal.isEmpty) {
                self.showErrorAlert("Cannot submit empty fields")
                return
            } else if (password != passwordVal) {
                self.showErrorAlert("Make sure password are matching")
                return
            }
            self.showActivityIndicator()
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    let currentUser = result?.user
                    self.defaults.set(currentUser?.uid, forKey: Configs.defaultUID)
                    self.defaults.set(currentUser?.email, forKey: Configs.defaultEmail)
                    self.defaults.set(currentUser?.displayName, forKey: Configs.defaultName)
                    self.addToUserDB(name: name, email: email)
                    // Refresh the tab views
                    self.notificationCenter.post(
                        name: Configs.notificationRefresh,
                        object: nil
                    )
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
                
                // Pop the current view controller
                self.navigationController?.popViewController(animated: true)
                
                // Dismiss the root view controller (if this VC was presented modally)
                self.navigationController?.dismiss(animated: true)
                
            } else {
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func addToUserDB(name: String, email: String) {
        let db = Firestore.firestore()
        if let currentUserID = self.defaults.object(forKey: Configs.defaultUID) as! String? {
            db.collection(FirebaseConstants.Users).document(currentUserID).setData([
                "name": name,
                "email": email,
                "id": currentUserID,
            ]) { error in
                if let error = error {
                    print("Error saving user data: \(error)")
                } else {
                    print("User data saved successfully.")
                }
            }
        } else {
            print("User data not saved")
        }
    }
}
