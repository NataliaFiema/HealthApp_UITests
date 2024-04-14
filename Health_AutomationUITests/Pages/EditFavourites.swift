//
//  EditFavourites.swift
//  Health_AutomationUITests
//
//  Created by NF on 06/04/2024.
//

import Foundation
import XCTest

class EditFavourites {
    private let app: XCUIApplication
    
    private var editFavouritesArea: XCUIElement { app.otherElements.containing(.staticText, identifier: "Edit Favourites").lastMatch }
    
    init(app: XCUIApplication) {
        self.app = app
        XCTAssertTrue(editFavouritesArea.waitForExistence(timeout: 10), "Edit Favourites screen not displayed")
    }
    
    func chooseTab(_ tab: EditFavouritesTabs) {
        let tabButton = editFavouritesArea.buttons[tab.rawValue]
        tabButton.waitForHittableAndTap()
    }
    
    func favouriteOption(_ option: FavouritesOptions) {
        let cell = editFavouritesArea.cells["UIA.Health.FavoritesEdit.\(option.identifier)"]
        cell.waitForHittableAndTap()
        
        let doneButton = editFavouritesArea.buttons["Done"]
        doneButton.waitForHittableAndTap()
    }
}

enum EditFavouritesTabs: String {
    case existingData = "Existing Data"
    case all = "All"
}

enum FavouritesOptions: String {
    case activeEnergy = "Active Energy"
    case activity = "Activity"
    case cyclingCadence = "Cycling Cadence"
    case cyclingDistance = "Cycling Distance"
    case cyclingFunctionalThresholdPower = "Cycling Functional Threshold Power"
    case cyclingPower = "Cycling Power"
    case cyclingSpeed = "Cycling Speed"
    case downhillSnowSportsDistance = "Downhill Snow Sports Distance"
    case exerciseMinutes = "Exercise Minutes"
    case flightsClimbed = "Flights Climbed"
    case moveMinutes = "Move Minutes"
    case nikeFuel = "NikeFuel"
    case physicalEffort = "Physical Effort"
    case pushes = "Pushes"
    case restingEnergy = "Resting Energy"
    case runningPower = "Running Power"
    
    var identifier: String {
        switch self {
        case .activeEnergy:
            return "HKQuantityTypeIdentifierActiveEnergyBurned"
        case .activity:
            return "HKActivitySummaryTypeIdentifier"
        case .cyclingCadence:
            return "HKQuantityTypeIdentifierCyclingCadence"
        case .cyclingDistance:
            return "HKQuantityTypeIdentifierDistanceCycling"
        case .cyclingFunctionalThresholdPower:
            return "HKQuantityTypeIdentifierCyclingFunctionalThresholdPower"
        case .cyclingPower:
            return "HKQuantityTypeIdentifierCyclingPower"
        case .cyclingSpeed:
            return "HKQuantityTypeIdentifierCyclingSpeed"
        case .downhillSnowSportsDistance:
            return "HKQuantityTypeIdentifierDistanceDownhillSnowSports"
        case .exerciseMinutes:
            return "HKQuantityTypeIdentifierAppleExerciseTime"
        case .flightsClimbed:
            return "HKQuantityTypeIdentifierFlightsClimbed"
        case .moveMinutes:
            return "HKQuantityTypeIdentifierAppleMoveTime"
        case .nikeFuel:
            return "HKQuantityTypeIdentifierNikeFuel"
        case .physicalEffort:
            return "HKQuantityTypeIdentifierPhysicalEffort"
        case .pushes:
            return "HKQuantityTypeIdentifierPushCount"
        case .restingEnergy:
            return "HKQuantityTypeIdentifierBasalEnergyBurned"
        case .runningPower:
            return "HKQuantityTypeIdentifierRunningPower"
        }
    }
}
