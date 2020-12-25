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
    
    let maxErrorAttempts = 3
    
    func searchFacts(_ searchText: String) -> Observable<[Fact]> {
        ChuckNorrisAPI.shared.searchFact(searchText)
            .retry { err in
                err.enumerated()
                    .flatMap { [weak self] attempt, err -> Observable<Int> in
                        guard let self = self else { return .error(err) }
                        if attempt >= self.maxErrorAttempts {
                            return .error(err)
                        }
                        return .timer(.seconds(3), scheduler: MainScheduler.instance)
                    }
            }
            .map(\.result)
    }
    
    // MARK: Error handling
    
}
