//
//  Date.swift
//  BeNote
//
//  Created by MAD on 11/19/24.
//

import Foundation

func todaysDate() -> String {
    let today = Date.now
    let formatter1 = DateFormatter()
    formatter1.dateFormat = "yMMd"
    return formatter1.string(from: today)
}
