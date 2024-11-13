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
    var _id: String
    
    init(name: String = "Anonymous", email: String, friends: [String] = [String](), _id: String) {
        self.name = name
        self.email = email
        self.friends = friends
        self._id = _id
    }
}
