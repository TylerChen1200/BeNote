//
//  FriendTableManager.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

extension ManageFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func confirmDelete(id: String) {
          let deleteAlert = UIAlertController(
              title: "Removing friend",
              message: "Are you sure want to remove this friend?",
              preferredStyle: .alert
          )
          deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (_) in
              self?.deleteFriend(id: id)
          }))
          deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
          
          present(deleteAlert, animated: true)
      }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == requestsTableView {
            return pendingRequests.count
        }
        return friendsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == requestsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! FriendRequestCell
            let request = pendingRequests[indexPath.row]
            
            cell.nameLabel.text = request.senderName
            cell.emailLabel.text = request.senderEmail
            
            cell.acceptButton.tag = indexPath.row
            cell.denyButton.tag = indexPath.row
            
            cell.acceptButton.addTarget(self, action: #selector(acceptRequest(_:)), for: .touchUpInside)
            cell.denyButton.addTarget(self, action: #selector(denyRequest(_:)), for: .touchUpInside)
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendsID, for: indexPath) as! FriendTableViewCell
        cell.labelName.text = friendsArray[indexPath.row].name
        cell.labelEmail.text = friendsArray[indexPath.row].email
        
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        buttonOptions.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        
        buttonOptions.menu = UIMenu(title: "Manage Friend?",
                                  children: [
                                    UIAction(title: "Remove Friend",handler: {(_) in
                                        self.confirmDelete(id: self.friendsArray[indexPath.row]._id)
                                    })
                                  ])
        cell.accessoryView = buttonOptions
        
        return cell
    }
    
}
