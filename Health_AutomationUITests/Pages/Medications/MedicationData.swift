//
//  MedicationData.swift
//  Health_AutomationUITests
//
//  Created by NF on 07/04/2024.
//

import Foundation


struct MedicationData {
    let name: String
    let displayedName: String
    let form: MedicationForms
    let strength: String
    let unit: Units
    let frequency: MedicationFrequency
    let notes: String
    
    static func random() -> MedicationData {
        MedicationData(
            name: CommonHelpers().randomString(of: 5),
            displayedName: CommonHelpers().randomString(of: 5),
            form: .capsule,
            strength: "10",
            unit: .mg,
            frequency: .asNeeded,
            notes: "N/A"
        )
    }
    
    var description: String {
        "\(displayedName), \(form.identifier), \(strength) \(unit.rawValue), Schedule: \(frequency.rawValue)"
    }
}

struct MedicationShapeAndColour {
    let shapeName: String
    let shapeColour: String
    let backgroundColour: String
    
    var description: String {
        "\(shapeName) \(shapeColour), background \(backgroundColour)"
    }
}
