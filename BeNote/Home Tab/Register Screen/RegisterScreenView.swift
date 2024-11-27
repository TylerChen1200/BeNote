//
//  RegisterScreenView.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class RegisterScreenView: UIView {
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textFieldPasswordVal: UITextField!
    var buttonRegister: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setuptextFieldName()
        setuptextFieldEmail()
        setuptextFieldPassword()
        setuptextFieldPasswordVal()
        setupbuttonRegister()
        
        initConstraints()
    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPasswordVal(){
        textFieldPasswordVal = UITextField()
        textFieldPasswordVal.placeholder = "Confirm password"
        textFieldPasswordVal.textContentType = .password
        textFieldPasswordVal.isSecureTextEntry = true
        textFieldPasswordVal.borderStyle = .roundedRect
        textFieldPasswordVal.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPasswordVal)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupbuttonRegister(){
        
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.backgroundColor = .tintColor
        buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonRegister.layer.cornerRadius = 10
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonRegister)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            textFieldName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            textFieldName.heightAnchor.constraint(equalToConstant: 44),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 44),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 44),
            
            textFieldPasswordVal.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            textFieldPasswordVal.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPasswordVal.heightAnchor.constraint(equalToConstant: 44),
            textFieldPasswordVal.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),

            buttonRegister.topAnchor.constraint(equalTo: textFieldPasswordVal.bottomAnchor, constant: 32),
            buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonRegister.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonRegister.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonRegister.heightAnchor.constraint(equalToConstant: 44),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
