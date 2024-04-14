//
//  MedicationTests.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

class MedicationTests: BaseTest {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let summaryPage = SummaryPage(app: app)
        let sidebar = summaryPage.sidebar
        let medicationPage = sidebar.openMedications()
        
        if medicationPage.medicationsCount > 0 {
            medicationPage.deleteAll()
        }
        XCTAssertEqual(0, medicationPage.medicationsCount, "There should be no drugs before test")
    }
    
    func testAddAndDeleteCapsuleDrug() throws {
        let medicationPage = MedicationsPage(app: app)
        let medicationData = MedicationData.random()
        
        // Add Medication
        let shapeAndColour = medicationPage.addMedication.fillInMedicationForm(medicationData: medicationData)
        let expectedMedicationData = "\(medicationData.description), \(shapeAndColour.description)"
        
        XCTAssertEqual(expectedMedicationData, medicationPage.getMedicationData(displayedName: medicationData.displayedName))
        
        // Verify medication details
        let drugDetails = medicationPage.openDrugDetails(displayedName: medicationData.displayedName)
        let details = drugDetails.getDetails()
        
        XCTAssertEqual(
            medicationData.displayedName,
            details.name,
            "Name of a drug does not match name in Details section"
        )
        XCTAssertTrue(
            details.form.contains(medicationData.form.rawValue.capitalized),
            "Form is not displayed properly in Details section"
        )
        XCTAssertTrue(
            details.form.contains("\(medicationData.strength) \(medicationData.unit.rawValue)"),
            "Medecine strength is not displayed properly in Details section"
        )
        XCTAssertEqual(
            medicationData.notes,
            details.notes,
            "Notes are not displayed properly in Details section"
        )
        XCTAssertEqual(
            "\(shapeAndColour.shapeName) \(shapeAndColour.shapeColour), background \(shapeAndColour.backgroundColour)",
            details.shapeAndColour,
            "Shape or colour does not match in Details section"
        )
        
        // Delete medication
        drugDetails.delete()
        XCTAssertFalse(medicationPage.doesDrugExists(displayedName: medicationData.displayedName), "\(medicationData.displayedName) drug was not deleted")
    }
}
