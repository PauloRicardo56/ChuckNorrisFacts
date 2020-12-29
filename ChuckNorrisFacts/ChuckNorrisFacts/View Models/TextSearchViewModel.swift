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
    let error = PublishSubject<APIErrorMessage>()
    let facts = PublishSubject<[Fact]>()
    
    func searchFact(_ searchText: String) {
        let params = [("query", searchText)]
        
        ChuckNorrisAPI.shared.buildRequest(pathComponent: "search", params: params)
            .catchAndReturn(.failure(.singleMessage(.noConnection)))
            .subscribe(onNext: { [weak self] (result) in
                do {
                    switch result {
                    case .success(let data):
                        let search = try JSONDecoder().decode(Search.self, from: data)
                        self?.facts.onNext(search.result)
                    case .failure(let err):
                        self?.error.onNext(err)
                    }
                } catch {
                    self?.error.onNext(.singleMessage(.parseError))
                }
            })
            .disposed(by: bag)
    }
    
//    func randomFact() -> Observable<Fact> {
//        ChuckNorrisAPI.shared.buildRequest(pathComponent: "random", params: [])
//            .map { try JSONDecoder().decode(Fact.self, from: $0) }
//    }
}
