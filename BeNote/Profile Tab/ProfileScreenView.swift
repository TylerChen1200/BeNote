////
////  ProfileScreenView.swift
////  BeNote
////
////  Created by MAD on 11/13/24.
////
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
        
        setupImageViewProfile() 
        setupLabelName()
        setupLabelEmail()
        setupLabelNotesWritten()
        setupTableViewNotesHistory()
        setupBackgroundImage()
        
        initConstraints()
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
        imageViewProfile.isUserInteractionEnabled = false // Change this to false
        self.addSubview(imageViewProfile)
    }
    
    func setupNameContainer() {
        labelName = UILabel()
        labelName.text = "Name"
        labelName.font = UIFont.boldSystemFont(ofSize: 24) // Larger font for name
        labelName.translatesAutoresizingMaskIntoConstraints = false
        
        labelEmail = UILabel()
        labelEmail.text = "Email"
        labelEmail.font = UIFont.systemFont(ofSize: 18)
        labelEmail.textColor = .gray
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        
        nameContainer = UIStackView(arrangedSubviews: [labelName, labelEmail])
        nameContainer.axis = .vertical
        nameContainer.spacing = 4
        nameContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nameContainer)
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
            
            nameContainer.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            nameContainer.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameContainer.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Notes written label
            labelNotesWritten.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 32),
            labelNotesWritten.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            // Table view for notes
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
