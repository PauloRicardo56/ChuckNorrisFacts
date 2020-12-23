//
//  TextSearchViewModelTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import XCTest
import RxSwift
import RxBlocking
@testable import ChuckNorrisFacts

class TextSearchViewModelTests: XCTestCase {
    
    /// Como estou usando o block em um relay (nunca termina) foi
    /// necessário skipar o primeiro valor (default do init) e pegar o
    /// primeiro seguinte (resultado da requisição).
    func test_searchedFacts() {
        let sut = TextSearchViewModel()
        sut.searchFacts("cook")
        let searchedResult = try! sut.facts
            .skip(1)
            .toBlocking()
            .first()!
        
        XCTAssertTrue(searchedResult.count > 0)
    }
}
