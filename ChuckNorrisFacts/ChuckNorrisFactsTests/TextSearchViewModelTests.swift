//
//  TextSearchViewModelTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import XCTest
import RxSwift
@testable import ChuckNorrisFacts

class TextSearchViewModelTests: XCTestCase {
    
    func test_searchedFacts() {
        let bag = DisposeBag()
        let apiMock = ChuckNorrisAPIMock()
        let sut = DefaultFactSearchViewModel(chuckNorrisAPI: apiMock)
        
        let expectedFact = Fact.stub()
        let expectedSearch = Search.stub(result: [expectedFact])
        
        apiMock.search = try! JSONEncoder().encode(expectedSearch)
        
        sut.didSearch(query: "")
        sut.facts
            .subscribe { search in
                XCTAssertEqual(search.first?.value, expectedFact.value)
            }
            .disposed(by: bag)
    }
}
