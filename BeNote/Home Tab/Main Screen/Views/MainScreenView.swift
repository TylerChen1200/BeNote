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
    var floatingButtonAddContact: UIButton!
    var tableViewNotes: UITableView!
    var modalOverlay: UIView!
    var modalView: UIView!
    var addNoteButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfilePic()
        setupLabelText()
        setupFloatingButtonAddContact()
        setupTableViewNotes()
        setupModal()
        initConstraints()
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
        self.addSubview(tableViewNotes)
    }
    
    func setupFloatingButtonAddContact(){
        floatingButtonAddContact = UIButton(type: .system)
        floatingButtonAddContact.setTitle("", for: .normal)
        floatingButtonAddContact.setImage(UIImage(systemName: "button.left.circle.fill.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonAddContact.contentHorizontalAlignment = .fill
        floatingButtonAddContact.contentVerticalAlignment = .fill
        floatingButtonAddContact.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddContact.layer.cornerRadius = 16
        floatingButtonAddContact.imageView?.layer.shadowOffset = .zero
        floatingButtonAddContact.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddContact.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddContact.imageView?.clipsToBounds = true
        floatingButtonAddContact.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddContact)
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
            
            floatingButtonAddContact.widthAnchor.constraint(equalToConstant: 48),
            floatingButtonAddContact.heightAnchor.constraint(equalToConstant: 48),
            floatingButtonAddContact.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            floatingButtonAddContact.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            modalOverlay.topAnchor.constraint(equalTo: self.topAnchor),
            modalOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            modalOverlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            modalOverlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            modalView.centerXAnchor.constraint(equalTo: modalOverlay.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: modalOverlay.centerYAnchor),
            modalView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            modalView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            modalView.heightAnchor.constraint(equalToConstant: 600)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

