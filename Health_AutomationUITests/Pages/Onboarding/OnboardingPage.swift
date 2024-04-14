//
//  OnboardingPage.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

class OnboardingPage {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func goThroughOnboardingIfDisplayed() {
        let predicate = NSPredicate(format: "identifier CONTAINS 'UIA.Health.BuddyOnboarding'")
        let welcomeScreen = app.otherElements.matching(predicate).firstMatch
        
        if welcomeScreen.waitForExistence(timeout: 5) {
            let continueButton = welcomeScreen.buttons["Continue"]
            while continueButton.waitForExistence(timeout: 2) {
                continueButton.tap()
            }
            
            //fill in required fields on User Info Screen
            fillInUserInfoField(field: .firstName)
            fillInUserInfoField(field: .lastName)
            let nextButton = app.buttons["UIA.Health.BuddyOnboarding.UserInfoScreen.ContinueButton"]
            nextButton.tap()
            
            //continue for notifications
            let continueNoticationsButton = app.buttons["UIA.Health.BuddyOnboarding.NotificationScreen.ContinueButton"]
            continueNoticationsButton.tap()
        }
    }
    
    private func fillInUserInfoField(field: UserInfoScreenData) {
        let table = app.tables["UIA.Health.BuddyOnboarding.UserInfoScreen"]
        let textField = table.cells["UIA.Health.BuddyOnboarding.UserInfoScreen.\(field.rawValue)"].textFields.firstMatch
        textField.clearAndEnterText(text: field.data)
    }
}

enum UserInfoScreenData: String {
    case firstName = "FirstNameEntry"
    case lastName = "LastNameEntry"
    case dateOfBirth = "DateOfBirthEntry"
    case sexEntry = "SexEntry"
    case heightEntry = "HeightEntry"
    case weightEntry = "WeightEntry"
    
    var data: String {
        switch self {
        case .firstName:
            "Annie"
        case .lastName:
            "Last"
        case .dateOfBirth:
            "01-01-2000"
        case .sexEntry:
            "Woman"
        case .heightEntry:
            "180"
        case .weightEntry:
            "70"
        }
    }
}
