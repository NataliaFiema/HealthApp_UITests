//
//  EditMedicationsList.swift
//  Health_AutomationUITests
//
//  Created by NF on 06/04/2024.
//

import Foundation
import XCTest

class EditMedicationsList {
    private let app: XCUIApplication
    
    private var navigationBar: XCUIElement { app.navigationBars["Edit Medications List"] }
    
    init(app: XCUIApplication) {
        self.app = app
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 10), "Edit Medications List not displayed")
    }
    
    func addMedication() -> AddMedicationPage {
        let addButton = app.tables.cells.containing(.staticText, identifier: "Add Medication").element
        addButton.tap()
        
        return AddMedicationPage(app: app)
    }
    
    func doesDrugExist(displayedName: String) -> Bool {
        let cell = getMedication(displayedName: displayedName)
        return cell.waitForExistence(timeout: 5)
    }
    
    func done() {
        let doneButton = app.buttons["Done"]
        doneButton.tap()
    }
    
    private func getMedication(displayedName: String) -> XCUIElement {
        app.cells.containing(.staticText, identifier: displayedName).firstMatch
    }
}
