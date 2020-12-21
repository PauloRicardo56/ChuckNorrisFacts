//
//  InitialViewController.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import UIKit
import RxSwift

class InitialViewController: UIViewController {
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchResult = ChuckNorrisAPI.shared
            .searchFact("ant")
            .asDriver(onErrorJustReturn: .empty)
        
        searchResult
            .drive(onNext: { print($0) })
            .disposed(by: bag)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        
        self.view = view
    }
}
