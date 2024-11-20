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
        cell.labelCreatorEmail.text = notesList[indexPath.row].creatorDisplayName
        cell.labelTimestampCreated.text = "\(notesList[indexPath.row].timestampCreated)"
        return cell
    }
}
