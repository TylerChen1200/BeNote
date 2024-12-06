//
//  RandomColorsForNotes.swift
//  BeNote
//
//  Created by MAD on 12/5/24.
//

import Foundation
import UIKit

let secondaryColor = UIColor(red: 55/255, green: 73/255, blue: 87/255, alpha: 1)

let pink = UIColor(red: 143/255, green: 0, blue: 24/255, alpha: 1)
let yellow = UIColor(red: 236/255, green: 167/255, blue: 44/255, alpha: 1)
let green = UIColor(red: 127/255, green: 145/255, blue: 114/255, alpha: 1)
let blue = secondaryColor
let purple = UIColor.tintColor

let allColors: [UIColor] = [pink, yellow, green, blue, purple]

func randomColor(_ prev: UIColor?) -> UIColor {
    var randomColor = purple
    while true {
        let randomIndex = Int.random(in: 0...4)
        randomColor = allColors[randomIndex]
        
        if (prev == nil || (prev != nil && randomColor != prev)) {
            break
        }
    }
    
    return randomColor
}
