//
//  ProfileTableViewCell.swift
//  BeNote
//
//  Created by MAD on 11/20/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelPrompt: UILabel!
    var labelReply: UILabel!
    var labelTimestampCreated: UILabel!
    var labelLocation: UILabel!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelPrompt()
        setupLabelReply()
        setupLabelTimestampCreated()
        setupLabelLocation()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelPrompt(){
        labelPrompt = UILabel()
        labelPrompt.font = UIFont.boldSystemFont(ofSize: 16)
        labelPrompt.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPrompt)
    }
    
    func setupLabelReply(){
        labelReply = UILabel()
        labelReply.font = UIFont.systemFont(ofSize: 14)
        labelReply.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelReply)
    }
    
    func setupLabelTimestampCreated(){
        labelTimestampCreated = UILabel()
        labelTimestampCreated.font = UIFont.systemFont(ofSize: 12)
        labelTimestampCreated.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestampCreated)
    }
    
    func setupLabelLocation() {
        labelLocation = UILabel()
        labelLocation.font = UIFont.systemFont(ofSize: 14) // Adjust font size
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLocation)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelPrompt.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelPrompt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelPrompt.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelPrompt.heightAnchor.constraint(equalToConstant: 20),
            labelPrompt.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelLocation.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 4),
            labelLocation.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelLocation.trailingAnchor.constraint(equalTo: labelPrompt.trailingAnchor),
            labelLocation.heightAnchor.constraint(equalToConstant: 16),
            
            labelReply.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 2), 
            labelReply.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelReply.heightAnchor.constraint(equalToConstant: 16),
            labelReply.widthAnchor.constraint(lessThanOrEqualTo: labelPrompt.widthAnchor),
            
            labelTimestampCreated.topAnchor.constraint(equalTo: labelReply.bottomAnchor, constant: 2),
            labelTimestampCreated.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelTimestampCreated.widthAnchor.constraint(lessThanOrEqualTo: labelPrompt.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
