//
//  ReactiveUITests.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 23/12/20.
//

import Foundation
import XCTest
@testable import ChuckNorrisFacts

class ReactiveUITests: XCTestCase {
    
    func test_biggerFontAccordingToTextSize() {
        let sut = ReactiveUIMock()
        let expectedFontSize: CGFloat = 22
        
        for _ in 0..<80 { sut.textLabel.text?.append("a") }
        
        XCTAssertEqual(sut.textLabel.font.pointSize, expectedFontSize)
    }
    
    func test_smallerFontAccordingToTextSize() {
        let sut = ReactiveUIMock()
        let expectedFontSize: CGFloat = 14
        
        for _ in 0..<81 { sut.textLabel.text?.append("a") }
        
        XCTAssertEqual(sut.textLabel.font.pointSize, expectedFontSize)
    }
}
