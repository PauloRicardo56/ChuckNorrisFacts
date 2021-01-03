//
//  Search+Stub.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 03/01/21.
//

import Foundation
@testable import ChuckNorrisFacts

extension Search {
    
    static func stub(total: Int = 1, result: [Fact] = [.stub()]) -> Search {
        .init(total: total, result: result)
    }
}
