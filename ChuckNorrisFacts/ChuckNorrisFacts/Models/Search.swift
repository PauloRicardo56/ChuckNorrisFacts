//
//  Search.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation

struct Search: Codable {
    let total: Int
    let result: [Fact]
}

extension Search {
    static let empty = Search(total: 0, result: [])
}
