//
//  ChuckNorrisAPIMock.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 03/01/21.
//

import Foundation
import RxSwift
import XCTest
@testable import ChuckNorrisFacts

class ChuckNorrisAPIMock: ChuckNorrisAPI {
    var search = Data()
    var error: APIErrorMessage?
    
    func buildRequest(
        method: String,
        pathComponent: String,
        params: [(String, String)]
    ) -> Observable<APIResult<Data, APIErrorMessage>> {
        if let error = error {
            return .of(.failure(error))
        } else {
            return .of(.success(search))
        }
    }
}
