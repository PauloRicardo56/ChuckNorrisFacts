//
//  APIResult.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 29/12/20.
//

import Foundation

enum APIResult<Value, Error> {
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
