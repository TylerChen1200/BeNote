//
//  LikesTableViewCell.swift
//  BeNote
//
//  Created by MAD on 12/7/24.
//

import UIKit

class LikesTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelEmail: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
                
        setupWrapperCellView()
        setupLabelEmail()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.borderColor = UIColor.tintColor.cgColor
        wrapperCellView.layer.borderWidth = 2.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.font = UIFont.systemFont(ofSize: 14)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelEmail)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelEmail.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelEmail.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelEmail.heightAnchor.constraint(equalToConstant: 20),
            labelEmail.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 30)
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
