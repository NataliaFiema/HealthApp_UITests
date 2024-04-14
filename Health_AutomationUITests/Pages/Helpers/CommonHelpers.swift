//
//  CommonHelpers.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

class CommonHelpers {
    func randomString(of: Int) -> String {
        let letters: [String] = ["q", "w", "e", "r", "y", "u", "i", "o","p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "1", "2", "3", "4","5", "6", "7", "8", "9", "0"]
        let length = letters.count
        var randomString = ""
        
        for _ in 0 ..< of {
            let randomInt = Int.random(in: 0 ..< length)
            randomString = randomString + "\(letters[randomInt])"
        }
        return randomString
    }
}

enum CommonIdentifiers {
    static let bundleIdentifier = "com.apple.Health"
}
