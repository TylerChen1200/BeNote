//
//  User.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var friends: [String]
    
    init(name: String = "Anonymous", email: String, friends: [String] = [String]()) {
        self.name = name
        self.email = email
        self.friends = friends
    }
}
