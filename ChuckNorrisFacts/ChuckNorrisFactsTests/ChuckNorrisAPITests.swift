//
//  ChuckNorrisAPITests.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import XCTest
import RxBlocking
@testable import ChuckNorrisFacts

class ChuckNorrisAPITests: XCTestCase {
    var sut: ChuckNorrisAPI!
    
    override func setUp() {
        super.setUp()
        sut = ChuckNorrisAPI.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_textSearchAPICall() {
        let textSearchResult = try? sut.searchFact("cake")
            .toBlocking()
            .first()
            .map { $0.total }
            
        XCTAssertTrue(try XCTUnwrap(textSearchResult) > 0)
    }
    
    func test_randomFactsAPICall() {
        let randomCount = try? sut.randomFact()
            .toBlocking()
            .first()
        
        XCTAssertNotNil(randomCount?.value)
    }
}
