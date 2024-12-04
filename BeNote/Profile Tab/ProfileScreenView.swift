////
////  ProfileScreenView.swift
////  BeNote
////
////  Created by MAD on 11/13/24.
////
//
//import UIKit
//
//class ProfileScreenView: UIView {
//
//    var labelName:UILabel!
//    var labelEmail:UILabel!
//    var labelNotesWritten:UILabel!
//    var tableViewNotesHistory: UITableView!
//    
//    override init(frame: CGRect){
//        super.init(frame: frame)
//        self.backgroundColor = .white
//        
//        setupLabelName()
//        setupLabelEmail()
//        setupLabelNotesWritten()
//        setupTableViewNotesHistory()
//        
//        setupBackgroundImage()
//        
//        initConstraints()
//    }
//    
//    func setupBackgroundImage() {
//        // Create an image view with the background image
//        let backgroundImageView = UIImageView(image: UIImage(named: "paper"))
//        backgroundImageView.contentMode = .scaleAspectFill
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//            
//        // Add the background image view to the current view
//        self.addSubview(backgroundImageView)
//            
//        // Send it to the back so it doesn't cover other elements
//        self.sendSubviewToBack(backgroundImageView)
//            
//        // Set up constraints for the background image
//        NSLayoutConstraint.activate([
//            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
//    }
//        
//    
//    func setupLabelName() {
//        labelName = UILabel()
//        labelName.text = "Name: "
//        labelName.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelName)
//    }
//    
//    func setupLabelEmail() {
//        labelEmail = UILabel()
//        labelEmail.text = "Email: "
//        labelEmail.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelEmail)
//    }
//    
//    func setupLabelNotesWritten() {
//        labelNotesWritten = UILabel()
//        labelNotesWritten.text = "Notes Written: "
//        labelNotesWritten.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelNotesWritten)
//    }
//    
//    func setupTableViewNotesHistory() {
//         tableViewNotesHistory = UITableView()
//         tableViewNotesHistory.register(ProfileTableViewCell.self, forCellReuseIdentifier: Configs.tableViewProfileID)
//        tableViewNotesHistory.backgroundColor = UIColor.clear
//        tableViewNotesHistory.separatorStyle = .none
//         tableViewNotesHistory.translatesAutoresizingMaskIntoConstraints = false
//         self.addSubview(tableViewNotesHistory)
//     }
//    
//    func initConstraints() {
//        NSLayoutConstraint.activate([
//            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
//            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            
//            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
//            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            
//            labelNotesWritten.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 32),
//            labelNotesWritten.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            
//            tableViewNotesHistory.topAnchor.constraint(equalTo: labelNotesWritten.bottomAnchor, constant: 8),
//            tableViewNotesHistory.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
//            tableViewNotesHistory.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            tableViewNotesHistory.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

import UIKit

class ProfileScreenView: UIView {

    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelNotesWritten: UILabel!
    var tableViewNotesHistory: UITableView!
    
    var profileImageView: UIImageView! // Placeholder profile image
    var nameContainer: UIStackView! // Stack view to contain name and email
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfileImageView()
        setupNameContainer()
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
    
    func setupProfileImageView() {
        profileImageView = UIImageView()
        profileImageView.layer.cornerRadius = 40 // Circular image
        profileImageView.layer.masksToBounds = true
        profileImageView.backgroundColor = .lightGray // Placeholder color
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImageView)
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
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
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
