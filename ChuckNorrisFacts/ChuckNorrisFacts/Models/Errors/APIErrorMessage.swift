//
//  APIErrorMessage.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 29/12/20.
//

import Foundation

struct APIErrorMessage: Codable {
    let timestamp, error, message: String
    let status: Int
    let violations: Violations
    
    static func singleMessage(_ message: ErrorMessages) -> APIErrorMessage {
        .init(timestamp: "", error: "", message: message.rawValue, status: 400, violations: .init(searchQuery: ""))
    }
}

// MARK: - Violations
struct Violations: Codable {
    let searchQuery: String

    enum CodingKeys: String, CodingKey {
        case searchQuery = "search.query"
    }
}
