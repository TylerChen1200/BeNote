//
//  FriendTableManager.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

extension ManageFriendsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendsID, for: indexPath) as! FriendTableViewCell
        cell.labelName.text = friendsArray[indexPath.row].name
        cell.labelEmail.text = friendsArray[indexPath.row].email
        
        //MARK: crating an accessory button...
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        //MARK: setting an icon from sf symbols...
        buttonOptions.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        
        //MARK: setting up menu for button options click...
        buttonOptions.menu = UIMenu(title: "Manage Friend?",
                                    children: [
                                        UIAction(title: "Remove Friend",handler: {(_) in
                                            self.confirmDelete(id: self.friendsArray[indexPath.row]._id)
                                        })
                                    ])
        //MARK: setting the button as an accessory of the cell...
        cell.accessoryView = buttonOptions
        
        return cell
    }
    
    func confirmDelete(id: String) {
        let deleteAlert = UIAlertController(title: "Removing friend", message: "Are you sure want to remove this friend?",
            preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(_) in
                self.deleteFriend(id: id)
            })
        )
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(deleteAlert, animated: true)
    }
}
