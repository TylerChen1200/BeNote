////
////  NotesTableViewCell.swift
////  BeNote
////
////  Created by MAD on 11/13/24.
////

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelReply: UILabel!
    var labelCreatorDisplayName: UILabel!
    var labelFreewrite: UILabel!
    var labelTimestampCreated: UILabel!
    var labelLocation: UILabel!
    var imageLikes: UIImageView!
    var labelLikes: UILabel!
    var profilePic: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
                
        setupWrapperCellView()
        setupLabelCreatorDisplayName()
        setupLabelFreewrite()
        setupLabelLocation()
        setupLabelReply()
        setupLabelTimestampCreated()
        setupProfilePic()
        setupImageLikes()
        setupLabelLikes()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        wrapperCellView.layer.cornerRadius = 8.0
        wrapperCellView.layer.borderColor = UIColor.tintColor.cgColor
        wrapperCellView.layer.borderWidth = 2.0
        wrapperCellView.layer.shadowColor = UIColor.black.cgColor
        wrapperCellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.2
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setupLabelCreatorDisplayName() {
        labelCreatorDisplayName = UILabel()
        labelCreatorDisplayName.font = UIFont.systemFont(ofSize: 14)
        labelCreatorDisplayName.textColor = .tintColor
        labelCreatorDisplayName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCreatorDisplayName)
    }
    
    func setupLabelFreewrite() {
        labelFreewrite = UILabel()
        labelFreewrite.font = UIFont.boldSystemFont(ofSize: 14)
        labelFreewrite.text = "Freewrite"
        labelFreewrite.textColor = .black
        labelFreewrite.isHidden = true
        labelFreewrite.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelFreewrite)
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
        labelReply.font = UIFont.systemFont(ofSize: 18)
        labelReply.textColor = .black
        labelReply.numberOfLines = 2  // Limit to two lines
        labelReply.lineBreakMode = .byTruncatingTail  // Show ellipsis ("...") at the end if text is truncated
        labelReply.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelReply)
    }
    
    func setupLabelTimestampCreated() {
        labelTimestampCreated = UILabel()
        labelTimestampCreated.font = UIFont.systemFont(ofSize: 14)
        labelTimestampCreated.textColor = .gray
        labelTimestampCreated.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestampCreated)
    }
    
    func setupProfilePic() {
        profilePic = UIImageView()
        profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleToFill
        profilePic.clipsToBounds = true
        profilePic.layer.masksToBounds = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(profilePic)
    }
    
    func setupImageLikes() {
        imageLikes = UIImageView()
        imageLikes.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal)
        imageLikes.contentMode = .scaleToFill
        imageLikes.clipsToBounds = true
        imageLikes.layer.masksToBounds = true
        imageLikes.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageLikes)
    }
    
    func setupLabelLikes() {
        labelLikes = UILabel()
        labelLikes.font = UIFont.boldSystemFont(ofSize: 14)
        labelLikes.textColor = .tintColor
        labelLikes.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLikes)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Wrapper cell view
            wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Creator display name
            profilePic.widthAnchor.constraint(equalToConstant: 32),
            profilePic.heightAnchor.constraint(equalToConstant: 32),
            profilePic.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            profilePic.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            
            labelCreatorDisplayName.topAnchor.constraint(equalTo: profilePic.topAnchor),
            labelCreatorDisplayName.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            labelCreatorDisplayName.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8),
            
            labelFreewrite.topAnchor.constraint(equalTo: profilePic.topAnchor),
            labelFreewrite.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            labelFreewrite.trailingAnchor.constraint(equalTo: imageLikes.leadingAnchor, constant: -8),
            
            imageLikes.topAnchor.constraint(equalTo: profilePic.topAnchor),
            imageLikes.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            imageLikes.widthAnchor.constraint(equalTo: imageLikes.heightAnchor),
            imageLikes.trailingAnchor.constraint(equalTo: labelLikes.leadingAnchor, constant: -2),
            
            labelLikes.topAnchor.constraint(equalTo: profilePic.topAnchor),
            labelLikes.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            labelLikes.trailingAnchor.constraint(equalTo: labelReply.trailingAnchor),
            
            // Reply label
            labelReply.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 8),
            labelReply.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelReply.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            
            // Timestamp label
            labelTimestampCreated.topAnchor.constraint(equalTo: labelReply.bottomAnchor, constant: 8),
            labelTimestampCreated.leadingAnchor.constraint(equalTo: labelReply.leadingAnchor),
            labelTimestampCreated.bottomAnchor.constraint(lessThanOrEqualTo: wrapperCellView.bottomAnchor, constant: -12),
            
            // Location label
            labelLocation.topAnchor.constraint(equalTo: labelReply.bottomAnchor, constant: 8),
            labelLocation.trailingAnchor.constraint(equalTo: labelReply.trailingAnchor),
            labelLocation.bottomAnchor.constraint(lessThanOrEqualTo: wrapperCellView.bottomAnchor, constant: -12),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
