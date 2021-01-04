//
//  FactsListViewSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 03/01/21.
//

import RxSwift
import FBSnapshotTestCase
@testable import ChuckNorrisFacts

class FactsListViewTests: FBSnapshotTestCase {
    var window: UIWindow!
    var coordinator: AppCoordinator!
    var vc: InitialViewController!
    
    override func setUp() {
        super.setUp()
//        recordMode = true
        
        window = .init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        coordinator = .init(window: window)
    }
    
    func test_whenHasFacts_showInTable() {
        
        let facts = PublishSubject<[Fact]>()
        vc = .init(viewModel: FactSearchViewModelMock.stub(facts: facts))
        vc.setSubscribers()
        
        facts.onNext([.stub(), .stub()])
        
        FBSnapshotVerifyViewController(vc)
    }
    
    func test_whenError_showAlert() throws {
        
        let error = PublishSubject<APIErrorMessage>()
        vc = .init(viewModel: FactSearchViewModelMock.stub(error: error))
        vc.coordinator = coordinator
        vc.setSubscribers()
        window.rootViewController = vc
        
        error.onNext(.singleMessage(.noFactFound))
        
        let result = XCTWaiter.wait(for: [.init()], timeout: 1)
        if result == XCTWaiter.Result.timedOut {
            let alert = try XCTUnwrap(vc.presentedViewController)
            FBSnapshotVerifyViewController(alert)
        }
    }
}
