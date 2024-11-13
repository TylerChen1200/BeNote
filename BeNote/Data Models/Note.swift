//
//  Note.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import Foundation

struct Note: Codable {
    var prompt: String
    var creatorEmail: String
    var creatorReply: String
    var timestampCreated: Date
}
