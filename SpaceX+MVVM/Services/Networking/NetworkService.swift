//
//  NetworkService.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

enum NetworkErrors: Error {
    case wrongURL
    case dataIsEmpty
    case decodeIsFail
    case noConnection
}

final class NetworkService {
    
    func baseRequest<T: Decodable>(request: URLRequest) -> Observable<T> {
        return Observable.create { obs in
            let items = URLSession.shared.rx.data(request: request)
                .subscribe { event in
                    switch event {
                    case .next(let data):
                        do {
                            let decodedModel = try JSONDecoder().decode(T.self, from: data)
                            obs.onNext(decodedModel)
                        }
                        catch {
                            obs.onError(NetworkErrors.decodeIsFail)
                        }
                    case .error(_):
                        obs.onError(NetworkErrors.dataIsEmpty)
                    case .completed:
                        obs.onCompleted()
                    }
                }
            return Disposables.create([items])
        }
    }
    
    func getRequest() -> URLRequest {
        let url = URL(string: "https://api.spacexdata.com/v4/launches/")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    func fetchLaunches() -> Observable<Response> {
        let request = getRequest()
        return self.baseRequest(request: request)
    }
}
