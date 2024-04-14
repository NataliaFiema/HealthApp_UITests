//
//  SummaryTests.swift
//  Health_AutomationUITests
//
//  Created by NF on 06/04/2024.
//

import Foundation
import XCTest

class SummaryTests: BaseTest {
    
    func testAddRemoveFavourites() {
        let summaryPage = SummaryPage(app: app)
        let editFavourites = summaryPage.editFavourites()
        
        editFavourites.chooseTab(.all)
        
        let option: FavouritesOptions = .nikeFuel
        editFavourites.favouriteOption(option)
        XCTAssertTrue(summaryPage.isFavourited(option), "\(option.rawValue) is not displayed in Favourites section")
        
        _ = summaryPage.editFavourites()
        editFavourites.chooseTab(.all)
        editFavourites.favouriteOption(option)
        XCTAssertFalse(summaryPage.isFavourited(option), "\(option.rawValue) is still displayed in Favourites section")
    }
}
