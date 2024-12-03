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
        setupBackgroundImage()
        
        initConstraints()
    }
    
    func setupBackgroundImage() {
        // Create an image view with the background image
        let backgroundImageView = UIImageView(image: UIImage(named: "paper"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            
        // Add the background image view to the current view
        self.addSubview(backgroundImageView)
            
        // Send it to the back so it doesn't cover other elements
        self.sendSubviewToBack(backgroundImageView)
            
        // Set up constraints for the background image
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [.foregroundColor: UIColor.gray])
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.backgroundColor = .clear
        textFieldName.layer.borderColor = UIColor.tintColor.cgColor
        textFieldName.layer.borderWidth = 2
        textFieldName.layer.cornerRadius = 6
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.gray])
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.backgroundColor = .clear
        textFieldEmail.layer.borderColor = UIColor.tintColor.cgColor
        textFieldEmail.layer.borderWidth = 2
        textFieldEmail.layer.cornerRadius = 6
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.gray])
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.backgroundColor = .clear
        textFieldPassword.layer.borderColor = UIColor.tintColor.cgColor
        textFieldPassword.layer.borderWidth = 2
        textFieldPassword.layer.cornerRadius = 6
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setuptextFieldPasswordVal(){
        textFieldPasswordVal = UITextField()
        textFieldPasswordVal.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [.foregroundColor: UIColor.gray])
        textFieldPasswordVal.textContentType = .password
        textFieldPasswordVal.isSecureTextEntry = true
        textFieldPasswordVal.borderStyle = .roundedRect
        textFieldPasswordVal.backgroundColor = .clear
        textFieldPasswordVal.layer.borderColor = UIColor.tintColor.cgColor
        textFieldPasswordVal.layer.borderWidth = 2
        textFieldPasswordVal.layer.cornerRadius = 6
        textFieldPasswordVal.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPasswordVal)
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
