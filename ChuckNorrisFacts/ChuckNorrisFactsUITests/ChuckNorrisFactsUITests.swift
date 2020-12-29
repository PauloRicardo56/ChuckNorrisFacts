//
//  ChuckNorrisFactsUITests.swift
//  ChuckNorrisFactsUITests
//
//  Created by Paulo Ricardo on 21/12/20.
//

import XCTest

class ChuckNorrisFactsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = .init()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_example() throws {
        
        let searchBar = app.navigationBars["ChuckNorrisFacts.InitialView"].children(matching: .searchField).element
        searchBar.tap()
        searchBar.typeText("Kik")
        
        app.buttons["Search"].tap()
        app.tables.staticTexts["Share"].tap()
        app.navigationBars["UIActivityContentView"].buttons["Close"].tap()
    }
}
