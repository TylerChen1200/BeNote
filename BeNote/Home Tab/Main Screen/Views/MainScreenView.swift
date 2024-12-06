//
//  MainScreenView.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class MainScreenView: UIView {
    var profilePic: UIImageView!
    var labelText: UILabel!
    var tableViewNotes: UITableView!
    var modalOverlay: UIView!
    var modalView: UIView!
    var addNoteButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfilePic()
        setupLabelText()
        setupTableViewNotes()
        setupModal()
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
    
    //MARK: initializing the UI elements...
    func setupProfilePic(){
        profilePic = UIImageView()
        profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleToFill
        profilePic.clipsToBounds = true
        profilePic.layer.masksToBounds = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePic)
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewNotes(){
        tableViewNotes = UITableView()
        tableViewNotes.register(NotesTableViewCell.self, forCellReuseIdentifier: Configs.notesViewContactsID)
        tableViewNotes.translatesAutoresizingMaskIntoConstraints = false
        tableViewNotes.backgroundColor = UIColor.clear
        tableViewNotes.separatorStyle = .none
        self.addSubview(tableViewNotes)
    }
    
    func setupModal() {
            // Overlay
        modalOverlay = UIView()
        modalOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        modalOverlay.isHidden = true // Initially hidden
        modalOverlay.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(modalOverlay)
        
        // Modal View
        modalView = UIView()
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 12
        modalView.layer.masksToBounds = true
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalOverlay.addSubview(modalView)
        
        // Add a label to the modal
        let modalLabel = UILabel()
        modalLabel.text = "Create your Note of the Day!"
        modalLabel.textAlignment = .center
        modalLabel.font = .boldSystemFont(ofSize: 16)
        modalLabel.numberOfLines = 0
        modalLabel.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(modalLabel)
            
        // Add a button to dismiss the modal
        addNoteButton = UIButton(type: .system)
        addNoteButton.setTitle("Create Note", for: .normal)
        addNoteButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(addNoteButton)
            
        // Constraints for modalLabel and dismissButton
        NSLayoutConstraint.activate([
            modalLabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 16),
            modalLabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 16),
            modalLabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -16),
            
            addNoteButton.topAnchor.constraint(equalTo: modalLabel.bottomAnchor, constant: 16),
            addNoteButton.centerXAnchor.constraint(equalTo: modalView.centerXAnchor),
            addNoteButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -16)
        ])
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            profilePic.widthAnchor.constraint(equalToConstant: 32),
            profilePic.heightAnchor.constraint(equalToConstant: 32),
            profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            profilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            labelText.topAnchor.constraint(equalTo: profilePic.topAnchor),
            labelText.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            labelText.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8),
            
            tableViewNotes.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 8),
            tableViewNotes.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewNotes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewNotes.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            modalOverlay.topAnchor.constraint(equalTo: self.topAnchor),
            modalOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            modalOverlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            modalOverlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            modalView.centerXAnchor.constraint(equalTo: modalOverlay.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: modalOverlay.centerYAnchor),
            modalView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            modalView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            modalView.heightAnchor.constraint(equalToConstant: 550)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

