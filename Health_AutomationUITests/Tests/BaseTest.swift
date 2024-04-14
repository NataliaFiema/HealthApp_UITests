//
//  BaseTest.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

class BaseTest: XCTestCase {
    let app = XCUIApplication(bundleIdentifier: "com.apple.Health")
    let helpers = CommonHelpers()
    
    override func setUpWithError() throws {
        app.launch()
        
        continueAfterFailure = false
        
        alertHandler {
            let onboarding = OnboardingPage(app: app)
            onboarding.goThroughOnboardingIfDisplayed()
        }
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func alertHandler(setup: () -> Void) {
        let handler = addUIInterruptionMonitor(withDescription: "Health access alert") { (alertElement) -> Bool in
            let allowButton = alertElement.buttons["Allow"]
            allowButton.tap()
            return true
        }
        setup()
        removeUIInterruptionMonitor(handler)
    }
}
