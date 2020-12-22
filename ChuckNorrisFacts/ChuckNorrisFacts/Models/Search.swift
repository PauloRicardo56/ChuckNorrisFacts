//
//  Search.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation

class Search: Codable {
    let total: Int
    let result: [Fact]
    
    init(total: Int, result: [Fact]) {
        self.total = total
        self.result = result
    }
}

extension Search {
    static let empty = Search(total: 0, result: [])
}
