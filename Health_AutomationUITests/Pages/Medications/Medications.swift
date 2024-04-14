//
//  Medications.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

class MedicationsPage {
    private let app: XCUIApplication
    private var navigationBar: XCUIElement { app.navigationBars.staticTexts["Medications"] }
    var addMedication: AddMedicationPage { startAddingMedication() }
    
    init(app: XCUIApplication) {
        self.app = app
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 10), "Medications screen not displayed")
    }
    
    var medicationsCount: Int {
        allMedications().count
    }
    
    func deleteAll() {
        let allDrugs = allMedications()
        var names: [String] = [String]()
        for element in allDrugs {
            let label = element.label
            let splittedLabel = label.components(separatedBy: ",")
            names.append(splittedLabel[0])
        }
        
        for name in names {
            let details = openDrugDetails(displayedName: name)
            details.delete()
        }
    }
    
    private func allMedications() -> [XCUIElement] {
        app.cells.containing(.staticText, identifier: "UIA.Health.MedicationNameLabel").allElementsBoundByIndex
    }
    
    private func startAddingMedication() -> AddMedicationPage {
        let startButton = app.buttons["UIA.Health.OnboardingTile.AddButton"]
        startButton.tap()
        
        return AddMedicationPage(app: app)
    }
    
    func getMedicationForm(displayedNameOfDrug: String) -> String {
        let cell = getExistingDrugCell(displayedName: displayedNameOfDrug)
        let formField = cell.staticTexts["UIA.Health.MedicationDetailLabel.Form"]
        return formField.label
    }
    
    func getMedicationStrength(displayedNameOfDrug: String) -> String {
        let cell = getExistingDrugCell(displayedName: displayedNameOfDrug)
        let strengthField = cell.staticTexts["UIA.Health.MedicationDetailLabel.Strength"]
        return strengthField.label
    }
    
    func getMedicationSchedule(displayedNameOfDrug: String) -> String {
        let cell = getExistingDrugCell(displayedName: displayedNameOfDrug)
        let scheduleField = cell.staticTexts["UIA.Health.MedicationDetailLabel.Schedule"]
        let splittedString: [String] = scheduleField.label.components(separatedBy: "Schedule: ")
        return splittedString[1]
    }
    
    func getMedicationData(displayedName: String) -> String {
        let cell = getExistingDrugCell(displayedName: displayedName)
        
        return cell.label
    }
    
    func openDrugDetails(displayedName: String) -> DrugDetails {
        let cell = getExistingDrugCell(displayedName: displayedName)
        XCTAssertTrue(cell.waitForExistence(timeout: 10), "Drug \(displayedName) does not exist in Your Medications")
        cell.tap()
        
        return DrugDetails(app: app, originalName: displayedName)
    }
    
    func doesDrugExists(displayedName: String) -> Bool {
        let cell = getExistingDrugCell(displayedName: displayedName)
        
        return cell.waitForExistence(timeout: 2)
    }
    
    private func getExistingDrugCell(displayedName: String) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS '\(displayedName)'")
        return app.cells.matching(predicate).element
    }
}

enum MedicationIdentifiers {
    static let textField = "UIA.Health.Medications.FieldCell.TextField"
}
