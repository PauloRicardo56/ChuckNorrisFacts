//
//  FactSearchViewModelMock.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 03/01/21.
//

import Foundation
import RxSwift
@testable import ChuckNorrisFacts

struct FactSearchViewModelMock: FactSearchViewModel {
    // MARK: Output
    var facts: PublishSubject<[Fact]>
    var error: PublishSubject<APIErrorMessage>
    
    // MARK: Input
    func didSearch(query: String) {}
    
    static func stub(
        facts: PublishSubject<[Fact]> = .init(),
        error: PublishSubject<APIErrorMessage> = .init()
    ) -> FactSearchViewModelMock {
        
        .init(facts: facts, error: error)
    }
}
