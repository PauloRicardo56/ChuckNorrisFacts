//
//  TextSearchViewModel.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import RxSwift
import RxCocoa

class TextSearchViewModel: ViewModel {
    let bag = DisposeBag()
    let facts = BehaviorRelay<[Fact]>(value: [])
    
    func searchFacts(_ searchText: String) {
        ChuckNorrisAPI.shared.searchFact(searchText)
            .map { $0.result }
            .bind(to: facts)
            .disposed(by: bag)
    }
}
