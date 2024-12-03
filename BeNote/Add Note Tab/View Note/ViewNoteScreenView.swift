//
//  ViewNoteScreenView.swift
//  BeNote
//
//  Created by MAD on 11/19/24.
//

import UIKit

class ViewNoteScreenView: UIView {

    var contentWrapper: UIScrollView!
    var labelInstructions: UILabel!
    var labelDailyPrompt: UILabel!
    var labelPrompt: UILabel!
    var labelFreeWrite: UILabel!
    var switchFreeWrite: UISwitch!
    var labelPromptReply: UITextView!
    var labelLocation: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
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
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupLabelInstructions() {
        labelInstructions = UILabel()
        labelInstructions.text = "Thanks for sharing your thoughts! Check out what your friends are saying"
        labelInstructions.lineBreakMode = .byWordWrapping
        labelInstructions.numberOfLines = 0
        labelInstructions.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelInstructions)
    }
    
    func setupLabelDailyPrompt() {
        labelDailyPrompt = UILabel()
        labelDailyPrompt.font = UIFont.italicSystemFont(ofSize: 12)
        labelDailyPrompt.text = "Daily Prompt:"
        labelDailyPrompt.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelDailyPrompt)
    }
    
    func setupLabelPrompt() {
        labelPrompt = UILabel()
        labelPrompt.font = UIFont.systemFont(ofSize: 18)
        labelPrompt.text = FirebaseConstants.DefaultPrompt
        labelPrompt.numberOfLines = 0
        labelPrompt.lineBreakMode = .byWordWrapping
        labelPrompt.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelPrompt)
    }
    
    func setupLabelFreeWrite() {
        labelFreeWrite = UILabel()
        labelFreeWrite.text = "Freewrite?"
        labelFreeWrite.font = UIFont.systemFont(ofSize: 18)
        labelFreeWrite.textColor = .gray
        labelFreeWrite.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelFreeWrite)
    }
    
    func setupSwitchFreeWrite() {
        switchFreeWrite = UISwitch()
        switchFreeWrite.isOn = false
        switchFreeWrite.setOn(false, animated: false)
        switchFreeWrite.isUserInteractionEnabled = false
        switchFreeWrite.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(switchFreeWrite)
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
        labelPromptReply.isScrollEnabled = false 
        contentWrapper.addSubview(labelPromptReply)
    }
    
    func setupLabelLocation() {
        labelLocation = UILabel()
        labelLocation.text = "Location: Not set"
        labelLocation.font = UIFont.systemFont(ofSize: 14)
        labelLocation.textColor = .black
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelLocation)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            contentWrapper.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelInstructions.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelInstructions.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelInstructions.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            labelInstructions.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            labelDailyPrompt.topAnchor.constraint(equalTo: labelInstructions.bottomAnchor, constant: 32),
            labelDailyPrompt.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelPrompt.topAnchor.constraint(equalTo: labelDailyPrompt.bottomAnchor, constant: 8),
            labelPrompt.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            labelPrompt.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            labelPrompt.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            labelFreeWrite.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 8),
            labelFreeWrite.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            
            switchFreeWrite.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 8),
            switchFreeWrite.leadingAnchor.constraint(equalTo: labelFreeWrite.trailingAnchor, constant: 16),
            
            labelLocation.topAnchor.constraint(equalTo: switchFreeWrite.bottomAnchor, constant: 16),
            labelLocation.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            labelLocation.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            labelPromptReply.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 8),
            labelPromptReply.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            labelPromptReply.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            labelPromptReply.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewNoteScreenView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contentHeight = textView.contentSize.height
        // Adjust the height based on the content size
        labelPromptReply.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
        layoutIfNeeded()
    }
}
