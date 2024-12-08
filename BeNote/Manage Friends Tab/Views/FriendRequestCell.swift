//
//  FriendRequestCell.swift
//  BeNote
//
//  Created by Ty C on 12/7/24.
//

import UIKit

class FriendRequestCell: UITableViewCell {
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var acceptButton: UIButton!
    var denyButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        nameLabel = UILabel()
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        emailLabel = UILabel()
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.textColor = .gray
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.backgroundColor = .systemGreen
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.layer.cornerRadius = 4
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        
        denyButton = UIButton(type: .system)
        denyButton.setTitle("Deny", for: .normal)
        denyButton.backgroundColor = .systemRed
        denyButton.setTitleColor(.white, for: .normal)
        denyButton.layer.cornerRadius = 4
        denyButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(acceptButton)
        contentView.addSubview(denyButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            denyButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            denyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            denyButton.widthAnchor.constraint(equalToConstant: 60),
            
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.trailingAnchor.constraint(equalTo: denyButton.leadingAnchor, constant: -8),
            acceptButton.widthAnchor.constraint(equalToConstant: 60),
            
            contentView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
