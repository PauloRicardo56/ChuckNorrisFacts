//
//  TextSearchViewModelTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import XCTest
import RxBlocking
@testable import ChuckNorrisFacts

class TextSearchViewModelTests: XCTestCase {
    
    func test_searchedFacts() {
        let sut = TextSearchViewModel()
        
        sut.didSearch(query: "cook")
        let searchedResult = try! sut.facts
            .toBlocking()
            .first()!

        XCTAssertTrue(searchedResult.count > 0)
    }
}
