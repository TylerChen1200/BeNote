//
//  EditProfileScreenView.swift
//  BeNote
//
//  Created by Ty C on 12/4/24.
//

import Foundation
import UIKit

class EditProfileScreenView: UIView {
    var imageViewProfile: UIImageView!
    var buttonChangePhoto: UIButton!
    var textFieldName: UITextField!
    var buttonSave: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupImageViewProfile()
        setupButtonChangePhoto()
        setupTextFieldName()
        setupButtonSave()
        setupBackgroundImage()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "paper"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundImageView)
        self.sendSubviewToBack(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupImageViewProfile() {
        imageViewProfile = UIImageView()
        imageViewProfile.contentMode = .scaleAspectFill
        imageViewProfile.clipsToBounds = true
        imageViewProfile.layer.cornerRadius = 50
        imageViewProfile.layer.borderWidth = 2
        imageViewProfile.layer.borderColor = UIColor.tintColor.cgColor
        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        imageViewProfile.backgroundColor = .systemGray5
        self.addSubview(imageViewProfile)
    }
    
    func setupButtonChangePhoto() {
        buttonChangePhoto = UIButton(type: .system)
        buttonChangePhoto.setTitle("Change Photo", for: .normal)
        buttonChangePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonChangePhoto)
    }
    
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.placeholder = "Enter Name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.font = .systemFont(ofSize: 16)
        textFieldName.textAlignment = .center
        self.addSubview(textFieldName)
    }
    
    func setupButtonSave() {
        buttonSave = UIButton(type: .system)
        buttonSave.setTitle("Save Changes", for: .normal)
        buttonSave.backgroundColor = .tintColor
        buttonSave.setTitleColor(.white, for: .normal)
        buttonSave.layer.cornerRadius = 5
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSave)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            imageViewProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageViewProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageViewProfile.widthAnchor.constraint(equalToConstant: 100),
            imageViewProfile.heightAnchor.constraint(equalToConstant: 100),
            
            buttonChangePhoto.topAnchor.constraint(equalTo: imageViewProfile.bottomAnchor, constant: 16),
            buttonChangePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            textFieldName.topAnchor.constraint(equalTo: buttonChangePhoto.bottomAnchor, constant: 32),
            textFieldName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldName.heightAnchor.constraint(equalToConstant: 44),
            
            buttonSave.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 32),
            buttonSave.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSave.widthAnchor.constraint(equalToConstant: 200),
            buttonSave.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
