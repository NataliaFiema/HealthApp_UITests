//
//  CommonHelpers_XCUIElementQuery.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

extension XCUIElementQuery {
    var lastMatch: XCUIElement {
        self.element(boundBy: self.count - 1)
    }
}
