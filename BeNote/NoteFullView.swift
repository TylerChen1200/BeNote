//
//  NoteFullView.swift
//  BeNote
//
//  Created by Jiana Ang on 12/1/24.
//

import UIKit

class NoteFullView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var labelPrompt: UILabel!
    var labelLocation: UILabel!
    var labelTimestampCreated: UILabel!
    var labelCreatorReply: UILabel!
    var labelLikes: UILabel!
    var buttonLikes: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupScrollView()
        setupContentView()
        setupLabels()
        setupLikeButton()
        
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
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }

    func setupLabels() {
        // Setup for the prompt label (larger font)
        labelPrompt = UILabel()
        labelPrompt.font = UIFont.boldSystemFont(ofSize: 24)
        labelPrompt.numberOfLines = 0
        labelPrompt.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelPrompt)
        
        // Setup for the location label
        labelLocation = UILabel()
        labelLocation.font = UIFont.systemFont(ofSize: 14)
        labelLocation.textColor = .black
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelLocation)
        
        // Setup for the timestamp label
        labelTimestampCreated = UILabel()
        labelTimestampCreated.font = UIFont.systemFont(ofSize: 12)
        labelTimestampCreated.textColor = .gray
        labelTimestampCreated.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTimestampCreated)
        
        // Setup for the likes number
        labelLikes = UILabel()
        labelLikes.font = UIFont.systemFont(ofSize: 16)
        labelLikes.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelLikes)
        
        // Setup for the creator's reply label (regular font)
        labelCreatorReply = UILabel()
        labelCreatorReply.font = UIFont.systemFont(ofSize: 16)
        labelCreatorReply.numberOfLines = 0
        labelCreatorReply.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelCreatorReply)
    }
    
    func setupLikeButton() {
        buttonLikes = UIButton(type: .system)
        buttonLikes.setImage(UIImage(systemName: "heart"), for: .normal)
        buttonLikes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLikes)
    }

    private func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            // Content view inside scroll view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Prompt label constraints
            labelPrompt.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            labelPrompt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelPrompt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Location label constraints
            labelLocation.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 8),
            labelLocation.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelLocation.trailingAnchor.constraint(equalTo: labelPrompt.trailingAnchor),
            
            // Timestamp label constraints
            labelTimestampCreated.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 8),
            labelTimestampCreated.leadingAnchor.constraint(equalTo: labelLocation.leadingAnchor),
            labelTimestampCreated.trailingAnchor.constraint(equalTo: labelLocation.trailingAnchor),
            
            // Likes label/buttonconstraints
            buttonLikes.heightAnchor.constraint(equalToConstant: 32),
            buttonLikes.widthAnchor.constraint(equalTo: buttonLikes.heightAnchor),
            buttonLikes.topAnchor.constraint(equalTo: labelTimestampCreated.bottomAnchor, constant: 8),
            buttonLikes.leadingAnchor.constraint(equalTo: labelLocation.leadingAnchor),
            
            labelLikes.topAnchor.constraint(equalTo: buttonLikes.topAnchor),
            labelLikes.bottomAnchor.constraint(equalTo: buttonLikes.bottomAnchor),
            labelLikes.leadingAnchor.constraint(equalTo: buttonLikes.trailingAnchor, constant: 4),
            
            // Creator's reply label constraints
            labelCreatorReply.topAnchor.constraint(equalTo: labelLikes.bottomAnchor, constant: 25),
            labelCreatorReply.leadingAnchor.constraint(equalTo: labelTimestampCreated.leadingAnchor),
            labelCreatorReply.trailingAnchor.constraint(equalTo: labelTimestampCreated.trailingAnchor),
            labelCreatorReply.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
