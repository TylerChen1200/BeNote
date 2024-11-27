//
//  NotesTableViewCell.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelPrompt: UILabel!
    var labelCreatorDisplayName: UILabel!
    var labelTimestampCreated: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelPrompt()
        setupLabelCreatorDisplayName()
        setupLabelTimestampCreated()
        
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
        labelPrompt.font = UIFont.boldSystemFont(ofSize: 20)
        labelPrompt.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPrompt)
    }
    
    func setupLabelCreatorDisplayName(){
        labelCreatorDisplayName = UILabel()
        labelCreatorDisplayName.font = UIFont.boldSystemFont(ofSize: 14)
        labelCreatorDisplayName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCreatorDisplayName)
    }
    
    func setupLabelTimestampCreated(){
        labelTimestampCreated = UILabel()
        labelTimestampCreated.font = UIFont.boldSystemFont(ofSize: 14)
        labelTimestampCreated.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestampCreated)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelPrompt.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelPrompt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelPrompt.heightAnchor.constraint(equalToConstant: 20),
            labelPrompt.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelCreatorDisplayName.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 2),
            labelCreatorDisplayName.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelCreatorDisplayName.heightAnchor.constraint(equalToConstant: 16),
            labelCreatorDisplayName.widthAnchor.constraint(lessThanOrEqualTo: labelPrompt.widthAnchor),
            
            labelTimestampCreated.topAnchor.constraint(equalTo: labelCreatorDisplayName.bottomAnchor, constant: 2),
            labelTimestampCreated.leadingAnchor.constraint(equalTo: labelCreatorDisplayName.leadingAnchor),
            labelTimestampCreated.heightAnchor.constraint(equalToConstant: 16),
            labelTimestampCreated.widthAnchor.constraint(lessThanOrEqualTo: labelPrompt.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 72)
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
