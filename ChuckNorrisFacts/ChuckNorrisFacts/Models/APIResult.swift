//
//  APIResult.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 29/12/20.
//

import Foundation

enum APIResult<Data, Error> {
    case success(Data)
    case failure(Error)
    
    init(value: Data) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
