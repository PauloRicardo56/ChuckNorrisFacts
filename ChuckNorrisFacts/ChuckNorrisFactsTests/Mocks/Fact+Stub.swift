//
//  Fact+Stub.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 03/01/21.
//

import Foundation
@testable import ChuckNorrisFacts

extension Fact {
    
    static func stub(categories: [String] = ["food"],
                     createdAt: String = "2020-01-05 13:42:18.823766",
                     iconURL: String = "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                     id: String = "e9LPe1QcTIWO8VqQJZmhhg",
                     updatedAt: String = "2020-01-05 13:42:18.823766",
                     url: String = "https://api.chucknorris.io/jokes/e9LPe1QcTIWO8VqQJZmhhg",
                     value: String = "Chuck Norris' favorite seafood restaurant always serves him armadillo on the half shell."
    ) -> Fact {
        .init(categories: categories,
              createdAt: createdAt,
              iconURL: iconURL,
              id: id,
              updatedAt: updatedAt,
              url: url,
              value: value)
    }
}
