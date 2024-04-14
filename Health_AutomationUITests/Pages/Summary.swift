//
//  HomePage.swift
//  Health_AutomationUITests
//
//  Created by NF on 04/04/2024.
//

import Foundation
import XCTest

class SummaryPage {
    private let app: XCUIApplication
    
    var sidebar: SidebarPage { openSidebar() }
    
    private var navigationBar: XCUIElement { app.navigationBars["Summary"] }
    
    init(app: XCUIApplication) {
        self.app = app
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 10), "Summary page not opened")
    }
    
    func startAddingMedication() -> MedicationsPage {
        let setUpMedication = app.cells["UIA.Health.SuggestedAction.SetUpMedication"].buttons["UIA.Health.SuggestedAction.SetUpMedication.PrimaryButton"]
        setUpMedication.tap()
        
        return MedicationsPage(app: app)
    }
    
    private func openSidebar() -> SidebarPage {
        let sidebarButton = app.buttons["ToggleSidebar"]
        sidebarButton.tap()
        
        return SidebarPage(app: app)
    }
    
    func editFavourites() -> EditFavourites {
        let editButton = app.buttons["UIA.Health.Favourites.Detail"]
        editButton.waitForHittableAndTap()
        
        return EditFavourites(app: app)
    }
    
    func isFavourited(_ option: FavouritesOptions) -> Bool {
        let snipped = app.cells["UIA.Health.Snippet.\(option.identifier)"]
        
        return snipped.exists
    }
}
