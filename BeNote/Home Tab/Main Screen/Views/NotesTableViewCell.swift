////
////  NotesTableViewCell.swift
////  BeNote
////
////  Created by MAD on 11/13/24.
////

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelPrompt: UILabel!
    var labelReply: UILabel!
    var labelCreatorDisplayName: UILabel!
    var labelTimestampCreated: UILabel!
    var labelLocation: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelPrompt()
        setupLabelCreatorDisplayName()
        setupLabelLocation()
        setupLabelReply()
        setupLabelTimestampCreated()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 8.0
        wrapperCellView.layer.shadowColor = UIColor.black.cgColor
        wrapperCellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.2
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setupLabelPrompt() {
        labelPrompt = UILabel()
        labelPrompt.font = UIFont.boldSystemFont(ofSize: 16) // Adjusted font size
        labelPrompt.textColor = .black // Set to black
        labelPrompt.numberOfLines = 1 // Restrict to a single line
        labelPrompt.lineBreakMode = .byTruncatingTail // Add "..." for overflow
        labelPrompt.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPrompt)
    }
    
    func setupLabelCreatorDisplayName() {
        labelCreatorDisplayName = UILabel()
        labelCreatorDisplayName.font = UIFont.systemFont(ofSize: 14)
        labelCreatorDisplayName.textColor = .tintColor
        labelCreatorDisplayName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCreatorDisplayName)
    }
    
    func setupLabelLocation() {
        labelLocation = UILabel()
        labelLocation.font = UIFont.systemFont(ofSize: 14)
        labelLocation.textColor = .black
        labelLocation.numberOfLines = 0
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLocation)
    }
    
    func setupLabelReply() {
        labelReply = UILabel()
        labelReply.font = UIFont.systemFont(ofSize: 16)
        labelReply.textColor = .darkGray
        labelReply.numberOfLines = 0
        labelReply.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelReply)
    }
    
    func setupLabelTimestampCreated() {
        labelTimestampCreated = UILabel()
        labelTimestampCreated.font = UIFont.systemFont(ofSize: 14)
        labelTimestampCreated.textColor = .lightGray
        labelTimestampCreated.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestampCreated)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Wrapper cell view
            wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Prompt label
            labelPrompt.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
            labelPrompt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelPrompt.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            
            // Creator display name
            labelCreatorDisplayName.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 8),
            labelCreatorDisplayName.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelCreatorDisplayName.trailingAnchor.constraint(equalTo: labelPrompt.trailingAnchor),
            
            // Location label
            labelLocation.topAnchor.constraint(equalTo: labelCreatorDisplayName.bottomAnchor, constant: 8),
            labelLocation.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelLocation.trailingAnchor.constraint(equalTo: labelPrompt.trailingAnchor),
            
            // Reply label
            labelReply.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 8),
            labelReply.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelReply.trailingAnchor.constraint(equalTo: labelPrompt.trailingAnchor),
            
            // Timestamp label
            labelTimestampCreated.topAnchor.constraint(equalTo: labelReply.bottomAnchor, constant: 8),
            labelTimestampCreated.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelTimestampCreated.trailingAnchor.constraint(equalTo: labelPrompt.trailingAnchor),
            labelTimestampCreated.bottomAnchor.constraint(lessThanOrEqualTo: wrapperCellView.bottomAnchor, constant: -12),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
