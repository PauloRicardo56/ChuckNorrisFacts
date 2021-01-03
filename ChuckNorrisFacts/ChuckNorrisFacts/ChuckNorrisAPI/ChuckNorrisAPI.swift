//
//  ChuckNorrisAPI.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 03/01/21.
//

import Foundation
import RxSwift

protocol ChuckNorrisAPI {
    func buildRequest(method: String, pathComponent: String, params: [(String, String)]) -> Observable<APIResult<Data, APIErrorMessage>>
}
