//
//  ViewNoteScreenView.swift
//  BeNote
//
//  Created by MAD on 11/19/24.
//

import UIKit

class ViewNoteScreenView: UIView {

    var contentWrapper: UIScrollView!
    var contentView: UIView!
    var labelInstructions: UILabel!
    var labelDailyPrompt: UILabel!
    var labelPrompt: UILabel!
    var labelFreeWrite: UILabel!
    var switchFreeWrite: UISwitch!
    var labelPromptReply: UITextView!
    var labelLocation: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupContentView()
        setupLabelInstructions()
        setupLabelDailyPrompt()
        setupLabelPrompt()
        setupLabelFreeWrite()
        setupSwitchFreeWrite()
        setupTextFieldPrompt()
        setupLabelLocation()
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
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(contentView)
    }
    
    func setupLabelInstructions() {
        labelInstructions = UILabel()
        labelInstructions.text = "Thanks for sharing your thoughts! Check out what your friends are saying"
        labelInstructions.lineBreakMode = .byWordWrapping
        labelInstructions.numberOfLines = 0
        labelInstructions.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelInstructions)
    }
    
    func setupLabelDailyPrompt() {
        labelDailyPrompt = UILabel()
        labelDailyPrompt.font = UIFont.italicSystemFont(ofSize: 12)
        labelDailyPrompt.text = "Daily Prompt:"
        labelDailyPrompt.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDailyPrompt)
    }
    
    func setupLabelPrompt() {
        labelPrompt = UILabel()
        labelPrompt.font = UIFont.systemFont(ofSize: 18)
        labelPrompt.text = FirebaseConstants.DefaultPrompt
        labelPrompt.numberOfLines = 0
        labelPrompt.lineBreakMode = .byWordWrapping
        labelPrompt.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelPrompt)
    }
    
    func setupLabelFreeWrite() {
        labelFreeWrite = UILabel()
        labelFreeWrite.text = "Freewrite?"
        labelFreeWrite.font = UIFont.systemFont(ofSize: 18)
        labelFreeWrite.textColor = .gray
        labelFreeWrite.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelFreeWrite)
    }
    
    func setupSwitchFreeWrite() {
        switchFreeWrite = UISwitch()
        switchFreeWrite.isOn = false
        switchFreeWrite.setOn(false, animated: false)
        switchFreeWrite.isUserInteractionEnabled = false
        switchFreeWrite.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(switchFreeWrite)
    }
    
    func setupTextFieldPrompt() {
        labelPromptReply = UITextView()
        labelPromptReply.text = "I think..."
        labelPromptReply.font = UIFont.systemFont(ofSize: 20)
        labelPromptReply.layer.cornerRadius = 6
        labelPromptReply.layer.borderWidth = 1.0
        labelPromptReply.translatesAutoresizingMaskIntoConstraints = false
        labelPromptReply.backgroundColor = .secondarySystemBackground
        labelPromptReply.isEditable = false
        labelPromptReply.isScrollEnabled = false // Allows the height to expand
        contentView.addSubview(labelPromptReply)
    }
    
    func setupLabelLocation() {
        labelLocation = UILabel()
        labelLocation.text = "Location: Not set"
        labelLocation.font = UIFont.systemFont(ofSize: 14)
        labelLocation.textColor = .black
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelLocation)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelInstructions.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelInstructions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelInstructions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            labelDailyPrompt.topAnchor.constraint(equalTo: labelInstructions.bottomAnchor, constant: 32),
            labelDailyPrompt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            labelPrompt.topAnchor.constraint(equalTo: labelDailyPrompt.bottomAnchor, constant: 8),
            labelPrompt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelPrompt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            labelFreeWrite.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 8),
            labelFreeWrite.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            switchFreeWrite.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 8),
            switchFreeWrite.leadingAnchor.constraint(equalTo: labelFreeWrite.trailingAnchor, constant: 16),
            
            labelLocation.topAnchor.constraint(equalTo: switchFreeWrite.bottomAnchor, constant: 16),
            labelLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            labelPromptReply.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 16),
            labelPromptReply.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelPromptReply.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelPromptReply.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

