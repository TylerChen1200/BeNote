//
//  ProfileScreenView.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class ProfileScreenView: UIView {

    var labelName:UILabel!
    var labelEmail:UILabel!
    var labelNotesWritten:UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelName()
        setupLabelEmail()
        setupLabelNotesWritten()
        
        initConstraints()
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Name: "
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email: "
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupLabelNotesWritten() {
        labelNotesWritten = UILabel()
        labelNotesWritten.text = "Notes Written: "
        labelNotesWritten.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelNotesWritten)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelNotesWritten.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 32),
            labelNotesWritten.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
