//
//  Note.swift
//  BeNote
//
//  Created by MAD on 11/13/24.
//

import Foundation
import UIKit

struct Note: Codable {
    var prompt: String
    var creatorDisplayName: String
    var creatorReply: String
    var location: String
    var timestampCreated: Date
    var likes: [String]
    var creatorID: String?
}
