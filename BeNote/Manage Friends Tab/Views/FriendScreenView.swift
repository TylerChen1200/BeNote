//
//  FriendScreenView.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class FriendScreenView: UIView {
    
    var tableViewFriends: UITableView!
    
    //MARK: bottom view for adding a Contact...
    var bottomAddView:UIView!
    var textFieldAddFriend:UITextField!
    var buttonAdd:UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewFriends()
        
        setupBottomAddView()
        setupTextFieldAddFriend()
        setupButtonAdd()
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
    
    //MARK: the table view to show the list of friends...
    func setupTableViewFriends(){
        tableViewFriends = UITableView()
        tableViewFriends.register(FriendTableViewCell.self, forCellReuseIdentifier: Configs.tableViewFriendsID)
        tableViewFriends.translatesAutoresizingMaskIntoConstraints = false
        tableViewFriends.backgroundColor = UIColor.clear
        tableViewFriends.separatorStyle = .none
        self.addSubview(tableViewFriends)
    }
    
    //MARK: the bottom add contact view....
    func setupBottomAddView(){
        bottomAddView = UIView()
        bottomAddView.backgroundColor = .white
        bottomAddView.layer.cornerRadius = 6
        bottomAddView.layer.shadowColor = UIColor.gray.cgColor
        bottomAddView.layer.shadowOffset = .zero
        bottomAddView.layer.shadowRadius = 4.0
        bottomAddView.layer.shadowOpacity = 0.7
        bottomAddView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomAddView)
    }
    
    func setupTextFieldAddFriend(){
        textFieldAddFriend = UITextField()
        textFieldAddFriend.placeholder = "Enter friend email"
        textFieldAddFriend.borderStyle = .roundedRect
        textFieldAddFriend.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(textFieldAddFriend)
    }
    
    func setupButtonAdd(){
        buttonAdd = UIButton(type: .system)
        buttonAdd.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonAdd.setTitle("Add Friend", for: .normal)
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(buttonAdd)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            //bottom add view...
            bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            buttonAdd.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
            buttonAdd.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
            buttonAdd.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
            
            textFieldAddFriend.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor, constant: -8),
            textFieldAddFriend.leadingAnchor.constraint(equalTo: buttonAdd.leadingAnchor, constant: 4),
            textFieldAddFriend.trailingAnchor.constraint(equalTo: buttonAdd.trailingAnchor, constant: -4),
            
            bottomAddView.topAnchor.constraint(equalTo: textFieldAddFriend.topAnchor, constant: -8),
            
            tableViewFriends.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableViewFriends.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewFriends.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewFriends.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor, constant: -8),
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
