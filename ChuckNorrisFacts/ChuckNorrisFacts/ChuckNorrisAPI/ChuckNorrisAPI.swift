//
//  ChuckNorrisAPI.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation
import RxSwift
import RxCocoa

class ChuckNorrisAPI {
    static let shared = ChuckNorrisAPI()
    let baseURL = URL(string: "https://api.chucknorris.io/jokes")!
    
    private init() {}
    
    // MARK: - API Calls
    func searchFact(_ searchText: String) -> Observable<Search> {
        let params = [("query", searchText)]
        
        return buildRequest(pathComponent: "search", params: params)
            .map { try JSONDecoder().decode(Search.self, from: $0) }
    }
    
    /// Método de construção da request utilizando RxCococa
    private func buildRequest(
        method: String = "GET",
        pathComponent: String,
        params: [(String, String)]
    ) -> Observable<Data> {
        
        var request: URLRequest
        let url = baseURL.appendingPathComponent(pathComponent)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        urlComponents.queryItems = params
            .map { URLQueryItem(name: $0.0, value: $0.1) }
        
        request = .init(url: urlComponents.url!)
        request.httpMethod = method
        
        let session = URLSession.shared
        return session.rx.data(request: request)
    }
}
