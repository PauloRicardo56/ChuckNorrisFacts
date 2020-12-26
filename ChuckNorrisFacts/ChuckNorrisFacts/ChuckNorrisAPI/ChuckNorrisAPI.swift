//
//  ChuckNorrisAPI.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation
import RxSwift
import RxCocoa

enum APIResult<Value> {
    case success(Value)
    case failure(APIError)
}

class ChuckNorrisAPI {
    static let shared = ChuckNorrisAPI()
    let baseURL = URL(string: "https://api.chucknorris.io/jokes")!
    
    private init() {}
    
    // MARK: Private methods
    /// Método de construção da request utilizando RxCococa
    func buildRequest(
        method: String = "GET",
        pathComponent: String,
        params: [(String, String)]
    ) -> Observable<APIResult<Data>> {
        
        let session = URLSession.shared
        let request = Observable<URLRequest>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            var request: URLRequest
            let url = self.baseURL.appendingPathComponent(pathComponent)
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            
            urlComponents.queryItems = params
                .map { URLQueryItem(name: $0.0, value: $0.1) }
            
            request = .init(url: urlComponents.url!)
            request.httpMethod = method
            
            observer.onNext(request)
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        return request.flatMap { request in
            session.rx.response(request: request)
                .map { response, data in
                    switch response.statusCode {
                    case 200..<300:
                        return .success(data)
                    default:
                        return .failure(.serverError)
                    }
                }
        }
    }
}
