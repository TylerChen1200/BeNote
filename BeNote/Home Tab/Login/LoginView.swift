//
//  LoginView.swift
//  BeNote
//
//  Created by Jiana Ang on 11/21/24.
//

import UIKit

class LoginView: UIView {
    
    var logoImageView: UIImageView!
    var welcomeLabel: UILabel!
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signUpButton: UIButton! // New sign up button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupComponents()
        setupBackgroundImage()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        // Logo Image View
        logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeLabel = createLabel(text: "Log in to share your thought for the day!", fontSize: 24, isBold: true)
        welcomeLabel.textColor = .tintColor
        welcomeLabel.numberOfLines = 0
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.textAlignment = .center
        
        // Email Label and TextField
        emailLabel = createLabel(text: "Email:", fontSize: 16, isBold: true)
        emailTextField = createTextField(placeholder: "Enter your email")
        emailTextField.keyboardType = .emailAddress
        emailTextField.backgroundColor = .clear
        emailTextField.layer.borderColor = UIColor.tintColor.cgColor
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 6
        emailTextField.autocapitalizationType = .none
        
        // Password Label and TextField
        passwordLabel = createLabel(text: "Password:", fontSize: 16, isBold: true)
        passwordTextField = createTextField(placeholder: "Enter your password")
        passwordTextField.backgroundColor = .clear
        passwordTextField.layer.borderColor = UIColor.tintColor.cgColor
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 6
        passwordTextField.isSecureTextEntry = true
        
        // Login Button
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .tintColor
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Sign Up Button (styled as hyperlink)
        signUpButton = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign Up")
        attributedString.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: (attributedString.string as NSString).range(of: "Sign Up"))
        signUpButton.setAttributedTitle(attributedString, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding subviews
        self.addSubview(welcomeLabel)
        self.addSubview(logoImageView)
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(signUpButton)

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
    
    func createLabel(text: String, fontSize: CGFloat, isBold: Bool) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = isBold ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .tintColor
        return label
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            // Welcome label constraints
            welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            // Logo constraints
            logoImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            // Email label constraints
            emailLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            // Email textfield constraints
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Password label constraints
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            // Password textfield constraints
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Login button constraints
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Sign Up button constraints
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signUpButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

