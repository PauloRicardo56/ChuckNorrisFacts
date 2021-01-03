//
//  FactSearchViewModel.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import RxSwift

protocol TextSearchViewModelInput {
    func didSearch(query: String)
//    func didRandomSearch()
}

protocol FactSearchViewModelOutput {
    var facts: PublishSubject<[Fact]> { get }
    var error: PublishSubject<APIErrorMessage> { get }
}

protocol FactSearchViewModel: TextSearchViewModelInput, FactSearchViewModelOutput {}


final class DefaultFactSearchViewModel: FactSearchViewModel {
    
    private let bag = DisposeBag()
    private let chuckNorrisAPI: ChuckNorrisAPI
    
    // MARK: Output
    let error = PublishSubject<APIErrorMessage>()
    let facts = PublishSubject<[Fact]>()
    
    init(chuckNorrisAPI: ChuckNorrisAPI) {
        self.chuckNorrisAPI = chuckNorrisAPI
    }
    
    // MARK: - Input
    func didSearch(query: String) {
        let params = [("query", query)]
        
        chuckNorrisAPI.buildRequest(method: .GET, pathComponent: "search", params: params)
            .catchAndReturn(.failure(.singleMessage(.noConnection)))
            .subscribe(onNext: { [weak self] result in
                do {
                    switch result {
                    case .success(let data):
                        let search = try JSONDecoder().decode(Search.self, from: data)
                        if search.result.isEmpty {
                            self?.facts.onNext([])
                            self?.error.onNext(.singleMessage(.noFactFound))
                        } else {
                            self?.facts.onNext(search.result)
                        }
                    case .failure(let err):
                        self?.error.onNext(err)
                    }
                } catch {
                    self?.error.onNext(.singleMessage(.parseError))
                }
            })
            .disposed(by: bag)
    }
    
//    func didRandomSearch() {
//        ChuckNorrisAPI.shared.buildRequest(pathComponent: "random", params: [])
//            .catchAndReturn(.failure(.singleMessage(.noConnection)))
//            .subscribe(onNext: { [weak self] result in
//                do {
//                    switch result {
//                    case .success(let data):
//                        let search = try JSONDecoder().decode(Search.self, from: data)
//                        self?.facts.onNext(search.result)
//                    case .failure(let err):
//                        self?.error.onNext(err)
//                    }
//                } catch {
//                    self?.error.onNext(.singleMessage(.parseError))
//                }
//            })
//            .disposed(by: bag)
//    }
}
