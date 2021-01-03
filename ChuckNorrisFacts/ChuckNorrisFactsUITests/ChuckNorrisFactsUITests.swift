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
    
    func test_example() throws {
        
        snapshot("EmptySearch")
        let searchBar = app.navigationBars["ChuckNorrisFacts.InitialView"].children(matching: .searchField).element
        
        searchBar.tap()
        searchBar.typeText("Kik")
        
        app.buttons["Search"].tap()
        
        app.tables.buttons["Share"].tap()
        snapshot("ShareFact")
        
        app.navigationBars["UIActivityContentView"].buttons["Close"].tap()
        snapshot("SearchResult")
    }
}
