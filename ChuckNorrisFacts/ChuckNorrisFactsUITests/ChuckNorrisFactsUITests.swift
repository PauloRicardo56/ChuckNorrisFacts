//
//  ChuckNorrisFactsUITests.swift
//  ChuckNorrisFactsUITests
//
//  Created by Paulo Ricardo on 21/12/20.
//

import XCTest
@testable import ChuckNorrisFacts

class ChuckNorrisFactsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = .init()
        setupSnapshot(app)
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func test_e2e() throws {
        
        snapshot("EmptySearch")
        let searchBar = app.searchFields[AccessibilityIdentifier.searchBar]
        
        searchBar.tap()
        searchBar.typeText("Kik")
        
        app.buttons["Search"].tap()
        
        app.tables.buttons["Share"].tap()
        snapshot("ShareFact")
        
        app.navigationBars["UIActivityContentView"].buttons["Close"].tap()
        snapshot("SearchResult")
    }
}
