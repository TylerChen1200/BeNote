//
//  NoteFullViewController.swift
//  BeNote
//
//  Created by Jiana Ang on 12/1/24.
//


import UIKit

class NoteFullViewController: UIViewController {
    
    let noteScreen = NoteFullView()
    var note: Note!
    
    override func loadView() {
        view = noteScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noteScreen.labelPrompt.text = note.prompt
        noteScreen.labelTimestampCreated.text = formatTimestamp(note.timestampCreated)
        noteScreen.labelLocation.text = note.location
        noteScreen.labelCreatorReply.text = note.creatorReply
    }

    func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a" // Month day year, and time without leading zeros (12-hour format)
        return formatter.string(from: timestamp)
    }
}
