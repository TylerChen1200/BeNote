//
//  ViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: setting up home tab bar...
        let tabHome = UINavigationController(rootViewController: HomeViewController())
        let tabHomeBarItem = UITabBarItem(
            title: "BeNote",
            image: UIImage(systemName: "house")?.withRenderingMode(.automatic),
            selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.automatic)
        )
        tabHome.tabBarItem = tabHomeBarItem
        tabHome.title = "BeNote"
        
        //MARK: setting up add note tab bar...
        let tabAddNote = UINavigationController(rootViewController: ViewNoteViewController())
        let tabAddNoteBarItem = UITabBarItem(
            title: "Add Note",
            image: UIImage(systemName: "plus.app")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "plus.app.fill")
        )
        tabAddNote.tabBarItem = tabAddNoteBarItem
        tabAddNote.title = "Add Note"
        
        //MARK: setting up friends tab bar...
        let tabFriends = UINavigationController(rootViewController: ManageFriendsViewController())
        let tabFriendsBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.2")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "person.2.fill")
        )
        tabFriends.tabBarItem = tabFriendsBarItem
        tabFriends.title = "Friends"
        
        //MARK: setting up profile tab bar...
        let tabProfile = UINavigationController(rootViewController: ProfileViewController())
        let tabProfileBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "person.circle.fill")
        )
        tabProfile.tabBarItem = tabProfileBarItem
        tabProfile.title = "Profile"
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [tabHome, tabAddNote, tabFriends, tabProfile]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the background image view
        let backgroundImageView = UIImageView(image: UIImage(named: "paper"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add it to the view
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        // Set constraints for full screen
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
