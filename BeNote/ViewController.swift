//
//  ViewController.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {
    // Singleton instance to manage global app state
    static let shared = ViewController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: setting up home tab bar...
        let tabHome = UINavigationController(rootViewController: HomeViewController())
        let tabHomeBarItem = UITabBarItem(
            title: "BeNote",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "house.fill")
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
    }
    
    // Method to refresh all view controllers in the tab bar
    func refreshAllTabs() {
        // Iterate through all view controllers
        viewControllers?.forEach { viewController in
            // Check if the view controller conforms to a custom refresh protocol
            if let refreshableVC = viewController as? RefreshableViewController {
                refreshableVC.refreshContent()
            }
        }
    }
}
