//
//  ChuckNorrisAPITests.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import XCTest
import RxBlocking
@testable import ChuckNorrisFacts

class ChuckNorrisAPITests: XCTestCase {
    var sut: DefaultChuckNorrisAPI!
    
    override func setUp() {
        super.setUp()
        sut = DefaultChuckNorrisAPI.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_textSearchAPICall() {
        let textSearchResult = try? sut.buildRequest(pathComponent: "search", params: [("query", "cake")])
            .toBlocking()
            .first()
            .map { result -> Data? in
                switch result {
                case .success(let data):
                    return data
                case .failure(_):
                    return nil
                }
            }
            
        XCTAssertNotNil(try XCTUnwrap(textSearchResult))
    }
    
    func test_restError() {
        let textSearchResult = try? sut.buildRequest(pathComponent: "search", params: [("query", "c")])
            .toBlocking()
            .first()
            .map { result -> APIErrorMessage? in
                switch result {
                case .success(_):
                    return nil
                case .failure(let err):
                    return err
                }
            }
        
        XCTAssertNotNil(try XCTUnwrap(textSearchResult))
    }
}
