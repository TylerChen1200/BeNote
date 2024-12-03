//
//  NotesTableViewManager.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.notesViewContactsID, for: indexPath) as! NotesTableViewCell
        cell.labelPrompt.text = notesList[indexPath.row].prompt
        cell.labelCreatorDisplayName.text = notesList[indexPath.row].creatorDisplayName
        cell.labelTimestampCreated.text = formatTimestamp(notesList[indexPath.row].timestampCreated)
        cell.labelReply.text = notesList[indexPath.row].creatorReply
        cell.labelLocation.text = notesList[indexPath.row].location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteFullVC = NoteFullViewController()
        noteFullVC.note = self.notesList[indexPath.row]
        self.navigationController?.pushViewController(noteFullVC, animated: true)
    }
    
    // Observing refresh
    func observeRefresh(){
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceived(notification:)),
            name: Configs.notificationRefresh, object: nil
        )
    }
    
    //MARK: handling notifications...
    @objc func notificationReceived(notification: Notification){
        // FIGURE OUT REFRESH
    }
    
    func logo() {
        let logoImage = UIImage(named: "logo.png")?.withRenderingMode(.alwaysOriginal)
        let leftButton = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
        
        // Create a custom view to add padding to the left button
        let leftButtonCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let leftImageView = UIImageView(image: logoImage)
        leftImageView.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        
        leftButtonCustomView.addSubview(leftImageView)
        
        leftButton.customView = leftButtonCustomView
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        return formatter.string(from: timestamp)
    }
}
