//
//  AddNoteView.swift
//  BeNote
//
//  Created by MAD on 11/17/24.
//

import UIKit

class AddNoteScreenView: UIView {

    var contentWrapper: UIScrollView!
    var labelInstructions: UILabel!
    var labelDailyPrompt: UILabel!
    var labelPrompt: UILabel!
    var labelFreeWrite: UILabel!
    var switchFreeWrite: UISwitch!
    var textFieldPrompt: UITextView!
    
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
        labelInstructions.text = "Please write your prompt for today"
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
        labelFreeWrite.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelFreeWrite)
    }
    
    func setupSwitchFreeWrite() {
        switchFreeWrite = UISwitch()
        switchFreeWrite.isOn = false
        switchFreeWrite.setOn(false, animated: false)
        switchFreeWrite.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(switchFreeWrite)
    }
    
    func setupTextFieldPrompt() {
        textFieldPrompt = UITextView()
        textFieldPrompt.text = "I think..."
        textFieldPrompt.font = UIFont.systemFont(ofSize: 20)
        textFieldPrompt.layer.cornerRadius = 6
        textFieldPrompt.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textFieldPrompt.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
        textFieldPrompt.layer.borderWidth = 1.0;
        textFieldPrompt.translatesAutoresizingMaskIntoConstraints = false
        textFieldPrompt.backgroundColor = .secondarySystemBackground
        textFieldPrompt.isScrollEnabled = false
        contentWrapper.addSubview(textFieldPrompt)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            contentWrapper.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelInstructions.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelInstructions.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
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
            
            textFieldPrompt.topAnchor.constraint(equalTo: switchFreeWrite.bottomAnchor, constant: 16),
            textFieldPrompt.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPrompt.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            textFieldPrompt.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            textFieldPrompt.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
