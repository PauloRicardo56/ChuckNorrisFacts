//
//  FactsListViewSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 03/01/21.
//

import Nimble
import Nimble_Snapshots
import Quick
import RxSwift
import XCTest
import FBSnapshotTestCase
@testable import ChuckNorrisFacts

class FactsListViewTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    func test_whenHasFacts_showInTable() {
        let facts = PublishSubject<[Fact]>()
        let vc = InitialViewController(viewModel: FactSearchViewModelMock.stub(facts: facts))
        vc.binds()
        
        facts.onNext([.stub()])
        
        FBSnapshotVerifyViewController(vc)
    }
}

//class FactsListViewSpec: QuickSpec {
//
//    override func spec() {
//
//        describe("InitialViewController") {
//            var vc: InitialViewController!
//            var facts: PublishSubject<[Fact]>!
//
//            context("did search returns valid result") {
//                beforeEach {
//                    facts = .init()
//                    vc = .init(viewModel: FactSearchViewModelMock.stub(facts: facts))
//                }
//
//                it("has result in list") {
//
//                    facts.onNext([.stub(), .stub(), .stub()])
//                    expect(vc) == recordSnapshot()
////                    expect(vc) == snapshot()
//                }
//            }
//
//            context("did search returns error") {
//
//                it("should display error message") {
//
//                }
//            }
//        }
//    }
//}

struct FactSearchViewModelMock: FactSearchViewModel {
    // MARK: Output
    var facts: PublishSubject<[Fact]>
    var error: PublishSubject<APIErrorMessage>
    
    // MARK: Input
    func didSearch(query: String) {}
    
    static func stub(
        facts: PublishSubject<[Fact]> = .init(),
        error: PublishSubject<APIErrorMessage> = .init()
    ) -> FactSearchViewModelMock {
        
        .init(facts: facts, error: error)
    }
}
