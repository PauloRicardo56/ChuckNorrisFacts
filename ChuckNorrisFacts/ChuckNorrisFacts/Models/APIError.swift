//
//  APIError.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 25/12/20.
//

import Foundation

enum APIError: Error {
    case noConnection
    case noResult
    case serverError
    case parseError
    case unknownError
    
    var message: String {
        switch self {
        case .noConnection:
            return "No internet connection"
        case .noResult:
            return "Fact with this text not found"
        case .serverError:
            return "Server error"
        case .parseError:
            return "Error while parsing"
        case .unknownError:
            return "Unknown error."
        }
    }
}
