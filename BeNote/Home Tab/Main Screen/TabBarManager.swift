//
//  TabBarManager.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import UIKit

extension ViewController {
    
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
