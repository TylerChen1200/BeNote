////
////  ProfileScreenView.swift
////  BeNote
////
////  Created by MAD on 11/13/24.
////
//

import UIKit

class ProfileScreenView: UIView {

    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelNotesWritten: UILabel!
    var tableViewNotesHistory: UITableView!
    
    var imageViewProfile: UIImageView! // Placeholder profile image
    var nameContainer: UIStackView! // Stack view to contain name and email
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupImageViewProfile()
        setupNameContainer()
        setupLabelNotesWritten()
        setupTableViewNotesHistory()
        
        setupBackgroundImage()
        
        initConstraints()
    }
    func setupLabelName() {
          labelName = UILabel()
          labelName.font = .systemFont(ofSize: 20, weight: .medium)  
          labelName.textAlignment = .center
          labelName.translatesAutoresizingMaskIntoConstraints = false
          self.addSubview(labelName)
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
            // Profile image and name container
            imageViewProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageViewProfile.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageViewProfile.widthAnchor.constraint(equalToConstant: 100),
            imageViewProfile.heightAnchor.constraint(equalToConstant: 100),
            
            nameContainer.centerYAnchor.constraint(equalTo: imageViewProfile.centerYAnchor),
            nameContainer.leadingAnchor.constraint(equalTo: imageViewProfile.trailingAnchor, constant: 16),
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
