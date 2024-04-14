//
//  Sidebar.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

class SidebarPage {
    let app: XCUIApplication
    
    private var navigationBar: XCUIElement { app.navigationBars["UIA.Health.Sidebar.NavigationBar.Header"] }
    private var toggleSidebarButton: XCUIElement { app.buttons["ToggleSidebar"] }
    
    init(app: XCUIApplication) {
        self.app = app
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 10), "Sidebar not displayed")
    }
    
    func openMedications() -> MedicationsPage {
        chooseSidebarOption(.medications)
        toggleSidebarButton.tap()
        
        return MedicationsPage(app: app)
    }
    
    private func chooseSidebarOption(_ option: SidebarOptions) {
        let optionCell = app.cells[option.identifier]
        optionCell.tap()
    }
}

enum SidebarOptions: String {
    case summary
    case sharing
    case activity
    case bodyMeasurements = "Body Measurements"
    case cycleTracking = "Cycle Tracking"
    case hearing
    case heart
    case medications
    case mentalWellbeing = "Mental Wellbeing"
    case mobility
    case nutrition
    case respiratory
    case sleep
    case symptoms
    case vitals
    case otherData
    case clinicalDocuments
    
    var identifier: String {
        "UIA.Health.SidebarItem.\(self.rawValue.capitalized)"
    }
}
