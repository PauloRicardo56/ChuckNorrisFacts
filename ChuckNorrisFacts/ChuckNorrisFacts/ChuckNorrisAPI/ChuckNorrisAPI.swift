//
//  ChuckNorrisAPI.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 03/01/21.
//

import Foundation
import RxSwift

protocol ChuckNorrisAPI {
    func buildRequest(method: HTTPMethod, pathComponent: String, params: [(String, String)]) -> Observable<APIResult<Data, APIErrorMessage>>
}

enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
    case PATCH
    case HEAD
}
