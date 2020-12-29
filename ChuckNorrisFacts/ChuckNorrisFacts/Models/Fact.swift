//
//  Fact.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation

class Fact: Codable {
    let categories: [String]
    let createdAt, iconURL, url: String
    let id, updatedAt, value: String

    enum CodingKeys: String, CodingKey {
        case categories
        case id, url, value
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case updatedAt = "updated_at"
    }
    
    init(
        categories: [String],
        createdAt: String,
        iconURL: String,
        id: String,
        updatedAt: String,
        url: String,
        value: String
    ) {
        self.categories = categories
        self.createdAt = createdAt
        self.iconURL = iconURL
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
        self.value = value
    }
}

extension Fact {
    static var empty = Fact(
        categories: [],
        createdAt: "",
        iconURL: "",
        id: "",
        updatedAt: "",
        url: "",
        value: "")
}
