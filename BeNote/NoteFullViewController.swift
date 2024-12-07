//
//  NoteFullViewController.swift
//  BeNote
//
//  Created by Jiana Ang on 12/1/24.
//


import UIKit
import FirebaseFirestore

class NoteFullViewController: UIViewController {
    
    let noteScreen = NoteFullView()
    var note: Note!
    let childProgressView = ProgressSpinnerViewController()
    let db = Firestore.firestore()
    let today = todaysDate()
    let defaults = UserDefaults.standard
    var liked : Bool = false
    var dispatch: HomeViewController = HomeViewController()
    var index = -1
    
    override func loadView() {
        view = noteScreen
        
        setLikeButtonImage()
        setLikeCount()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noteScreen.labelPrompt.text = note.prompt
        noteScreen.labelTimestampCreated.text = formatTimestamp(note.timestampCreated)
        noteScreen.labelLocation.text = note.location
        noteScreen.labelCreatorReply.text = note.creatorReply
        
        noteScreen.buttonLikes.addTarget(self, action: #selector(addLike), for: .touchUpInside)
    }

    func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a" // Month day year, and time without leading zeros (12-hour format)
        return formatter.string(from: timestamp)
    }
    
    func setLikeButtonImage() {
        if (self.liked) {
            noteScreen.buttonLikes.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            noteScreen.buttonLikes.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setLikeCount() {
        noteScreen.labelLikes.text = String(self.note.likes.count)
    }
    
    @objc func addLike() {
        self.showActivityIndicator()
        
        if let currentUserEmail = self.defaults.object(forKey: Configs.defaultEmail) as! String?,
           let noteAuthor = self.note.creatorID {
            
            // create the new likes list
            var newLikes = note.likes
            newLikes = newLikes.filter{ $0 != currentUserEmail }
            if (!self.liked) {
                newLikes.append(currentUserEmail)
            }
            
            self.note.likes = newLikes
            dispatch.notesList[index] = self.note
            
            self.liked = !self.liked
            
            // save note to notes collection
            db.collection(FirebaseConstants.Notes)
                .document(FirebaseConstants.Notes)
                .collection(self.today)
                .document(noteAuthor)
                .setData([
                    "prompt": note.prompt,
                    "creatorDisplayName": self.note.creatorDisplayName,
                    "creatorReply": self.note.creatorReply,
                    "location" : self.note.location,
                    "timestampCreated": self.note.timestampCreated,
                    "likes": newLikes
                        ]) { error in
                            if let error = error {
                                print("Error saving note data: \(error)")
                            } else {
                                print("Note saved successfully.")
                            }
                        }
            
            // save note to user collection
            db.collection(FirebaseConstants.Users)
                .document(noteAuthor)
                .collection(FirebaseConstants.Notes)
                .document(self.today)
                .setData([
                    "prompt": note.prompt,
                    "creatorDisplayName": self.note.creatorDisplayName,
                    "creatorReply": self.note.creatorReply,
                    "location" : self.note.location,
                    "timestampCreated": self.note.timestampCreated,
                    "likes": newLikes
                        ]) { error in
                            if let error = error {
                                print("Error saving note data: \(error)")
                            } else {
                                print("Note saved successfully.")
                            }
                        }
            
            setLikeButtonImage()
            setLikeCount()
            
            self.hideActivityIndicator()
        }
    }
}
