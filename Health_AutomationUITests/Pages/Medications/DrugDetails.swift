//
//  DrugDetails.swift
//  Health_AutomationUITests
//
//  Created by NF on 06/04/2024.
//

import Foundation
import XCTest

class DrugDetails {
    private let app: XCUIApplication
    private let originalName: String
    
    private var navigationBar: XCUIElement { app.navigationBars.staticTexts[originalName] }
    
    init(app: XCUIApplication, originalName: String) {
        self.app = app
        self.originalName = originalName
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 10), "Drug \(originalName) not displayed")
    }
    
    func getDetails() -> (name: String, form: String, notes: String, shapeAndColour: String) {
        let name = app.staticTexts["UIA.Health.MedicationDetailsCard.PrimaryLabel"].label
        let form = app.staticTexts["UIA.Health.MedicationDetailsCard.CapitionLabel"].label
        let notes = app.staticTexts["UIA.Health.MedicationDetailsCard.NotesLabel"].label
        let shapeAndColour = app.otherElements["MedicationView"].label
        
        return (name: name, form: form, notes: notes, shapeAndColour: shapeAndColour)
    }
    
    func delete() {
        let deleteButton = app.cells["UIA.Health.Medications.ConceptDetail.Option.DeleteMedication.Button"]
        deleteButton.tap()
        
        let confirmDeletion = app.alerts.buttons["Delete Medication"]
        confirmDeletion.tap()
    }
}
