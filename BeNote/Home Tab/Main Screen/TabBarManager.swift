//
//  TabBarManager.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

extension ViewController {
    @objc func setTabNames() {
        tabBarController?.tabBar.items?[0].title = "BeNote"
        tabBarController?.tabBar.items?[1].title = "Add Note"
        tabBarController?.tabBar.items?[2].title = "Friends"
        tabBarController?.tabBar.items?[3].title = "Profile"
        
        tabBarController?.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBarController?.tabBar.items?[1].image = UIImage(systemName: "plus.app")
        tabBarController?.tabBar.items?[2].image = UIImage(systemName: "person.2.fill")
        tabBarController?.tabBar.items?[3].image = UIImage(systemName: "person.circle")
    }
    
    func disableTabs() {
        tabBarController?.tabBar.items?[1].isEnabled = false
        tabBarController?.tabBar.items?[2].isEnabled = false
        tabBarController?.tabBar.items?[3].isEnabled = false
    }
    
    func enableTabs() {
        tabBarController?.tabBar.items?[1].isEnabled = true
        tabBarController?.tabBar.items?[2].isEnabled = true
        tabBarController?.tabBar.items?[3].isEnabled = true
    }
}
