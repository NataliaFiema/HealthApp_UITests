//
//  AddMedicationPage.swift
//  Health_AutomationUITests
//
//  Created by NF on 06/04/2024.
//

import Foundation
import XCTest

class AddMedicationPage {
    private let app: XCUIApplication
    
    private var textField: XCUIElement { app.textFields[MedicationIdentifiers.textField] }
    private var nextButton: XCUIElement { app.buttons["UIA.Health.Medications.Onboarding.PrimaryButton"] }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func fillInMedicationName(name: String) {
        textField.clearAndEnterText(text: name)
        
        nextButton.tap()
    }
    
    func chooseMedicationType(type: MedicationForms) {
        let typeField = app.cells["UIA.Health.Medication.ManualFormCell.\(type.identifier)"]
        typeField.tap()
        
        nextButton.waitForHittableAndTap()
    }
    
    func setMedicationStrength(strength: String, unit: Units) {
        textField.clearAndEnterText(text: strength)
        
        let unitField = app.cells[unit.identifier]
        unitField.tap()
        nextButton.waitForHittableAndTap()
    }
    
    func setCalendar(frequency: MedicationFrequency) {
        let frequencyCell = app.cells["UIA.Health.Medications.Scheduling.FrequencyCell"]
        frequencyCell.tap()
        
        let frequencyType = app.cells[frequency.identifier]
        frequencyType.tap()
        
        let doneButton = app.navigationBars["Frequency"].buttons["Done"]
        doneButton.waitForHittableAndTap()
        
        nextButton.waitForHittableAndTap()
    }
    
    func chooseRandomShape() -> String {
        let predicate: NSPredicate = NSPredicate(format: "identifier CONTAINS 'UIA.HealthMedications.ShapeCell.'")
        let shapes: [XCUIElement] = app.cells.matching(predicate).allElementsBoundByIndex
        
        let randomInt = Int.random(in: 0 ..< shapes.count - 1)
        let randomShapeName = shapes[randomInt].label
        shapes[randomInt].tap()
        
        nextButton.waitForHittableAndTap()
        return randomShapeName
    }
    
    func chooseRandomColour() -> (shapeColour: String, backgroundColour: String) {
        let predicate: NSPredicate = NSPredicate(format: "identifier CONTAINS 'UIA.HealthMedications.ColorCell'")
        let colors: [XCUIElement] = app.cells.matching(predicate).allElementsBoundByIndex
        
        let randomShapeIndex = Int.random(in: 0 ..< 12)
        let randomBackgroundIndex = Int.random(in: 12 ..< colors.count - 1)
        let colourNames: (shapeColour: String, backgroundColour: String) = (colors[randomShapeIndex].label, colors[randomBackgroundIndex].label)
        
        colors[randomShapeIndex].tap()
        colors[randomBackgroundIndex].tap()
        
        nextButton.waitForHittableAndTap()
        return colourNames
    }
    
    func provideAdditionalDetails(displayName: String, notes: String) {
        textField.clearAndEnterText(text: displayName)
        
        let notesField = app.textViews["UIA.Health.Medications.ReviewDetails.NotesField"]
        notesField.clearAndEnterText(text: notes)
        
        nextButton.waitForHittableAndTap()
    }
    
    func fillInMedicationForm(medicationData: MedicationData) -> MedicationShapeAndColour {
        fillInMedicationName(name: medicationData.name)
        chooseMedicationType(type: medicationData.form)
        setMedicationStrength(strength: medicationData.strength, unit: medicationData.unit)
        setCalendar(frequency: medicationData.frequency)
        let medicationShape = chooseRandomShape()
        let medicationColours: (shapeColour: String, backgroundColour: String) = chooseRandomColour()
        provideAdditionalDetails(displayName: medicationData.displayedName, notes: medicationData.notes)
        
        return MedicationShapeAndColour(shapeName: medicationShape, shapeColour: medicationColours.shapeColour, backgroundColour: medicationColours.backgroundColour)
    }
}



enum MedicationForms: String {
    case capsule
    case tablet
    case liquid
    case topical
    case cream
    case device
    case drops
    case foam
    case gel
    case inhaler
    case injection
    case lotion
    case ointment
    case patch
    case powder
    case spray
    case suppository
    
    var identifier: String {
        self.rawValue.capitalized
    }
}

enum Units: String {
    case mg
    case mcg
    case g
    case ml
    case procentage = "%"
    
    var identifier: String {
        "UIA.Health.ManualStrengthStep.UnitCell.\(self.rawValue)"
    }
}

enum MedicationFrequency: String {
    case regularIntervals = "At Regular Intervals"
    case specificDays = "On Specific Days of the Week"
    case asNeeded = "As Needed"
    
    var identifier: String {
        "UIA.Health.Medications.Scheduling.Frequency.\(self.rawValue)"
    }
}
