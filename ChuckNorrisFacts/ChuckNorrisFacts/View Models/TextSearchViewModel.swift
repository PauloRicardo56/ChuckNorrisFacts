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
    
    func searchFact(_ searchText: String) -> Observable<APIResult<Search, APIErrorMessage>> {
        let params = [("query", searchText)]
        
        return ChuckNorrisAPI.shared.buildRequest(pathComponent: "search", params: params)
            .catchAndReturn(.failure(.singleMessage(.noConnection)))
            .map { result in
                do {
                    switch result {
                    case .success(let data):
                        return .success(try JSONDecoder().decode(Search.self, from: data))
                    case .failure(let err):
                        return .failure(err)
                    }
                } catch {
                    return .failure(.singleMessage(.parseError))
                }
            }
    }
    
//    func randomFact() -> Observable<Fact> {
//        ChuckNorrisAPI.shared.buildRequest(pathComponent: "random", params: [])
//            .map { try JSONDecoder().decode(Fact.self, from: $0) }
//    }
}
