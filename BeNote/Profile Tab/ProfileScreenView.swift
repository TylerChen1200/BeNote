//
//  ProfileScreenView.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit


class ProfileScreenView: UIView {
    
    var imageViewProfile: UIImageView!
    var labelName:UILabel!
    var labelEmail:UILabel!
    var labelNotesWritten:UILabel!
    var tableViewNotesHistory: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupImageViewProfile() // Add this line
        setupLabelName()
        setupLabelEmail()
        setupLabelNotesWritten()
        setupTableViewNotesHistory()
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
    func setupImageViewProfile() {
        imageViewProfile = UIImageView()
        imageViewProfile.contentMode = .scaleAspectFill
        imageViewProfile.clipsToBounds = true
        imageViewProfile.layer.cornerRadius = 50
        imageViewProfile.layer.borderWidth = 2
        imageViewProfile.layer.borderColor = UIColor.tintColor.cgColor
        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        imageViewProfile.isUserInteractionEnabled = false // Change this to false
        self.addSubview(imageViewProfile)
    }
        
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Name: "
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email: "
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupLabelNotesWritten() {
        labelNotesWritten = UILabel()
        labelNotesWritten.text = "Notes Written: "
        labelNotesWritten.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelNotesWritten)
    }
    
    func setupTableViewNotesHistory() {
         tableViewNotesHistory = UITableView()
         tableViewNotesHistory.register(ProfileTableViewCell.self, forCellReuseIdentifier: Configs.tableViewProfileID)
        tableViewNotesHistory.backgroundColor = UIColor.clear
        tableViewNotesHistory.separatorStyle = .none
         tableViewNotesHistory.translatesAutoresizingMaskIntoConstraints = false
         self.addSubview(tableViewNotesHistory)
     }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            imageViewProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageViewProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageViewProfile.widthAnchor.constraint(equalToConstant: 100),
            imageViewProfile.heightAnchor.constraint(equalToConstant: 100),
            
            labelName.topAnchor.constraint(equalTo: imageViewProfile.bottomAnchor, constant: 16),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelNotesWritten.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 32),
            labelNotesWritten.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            tableViewNotesHistory.topAnchor.constraint(equalTo: labelNotesWritten.bottomAnchor, constant: 8),
            tableViewNotesHistory.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewNotesHistory.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewNotesHistory.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
