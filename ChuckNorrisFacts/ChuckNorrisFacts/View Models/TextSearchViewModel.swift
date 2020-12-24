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
    
    func searchFacts(_ searchText: String) -> Observable<[Fact]> {
        ChuckNorrisAPI.shared.searchFact(searchText)
            .map(\.result)
    }
}
