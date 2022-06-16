//
//  MainViewModel.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import Foundation
import RxSwift
import RxRelay

protocol LaunchesViewModelOutputs {
    var launches: Observable<Response> { get }
}

protocol LaunchesViewModelType {
    var outputs: LaunchesViewModelOutputs { get }
}

protocol LaunchesViewModelProtocol: LaunchesViewModelType &  LaunchesViewModelOutputs {}

class MainViewModel: LaunchesViewModelProtocol {
    
    var outputs: LaunchesViewModelOutputs { return self }
        
    var launches: Observable<Response>
    
    private let disposeBag = DisposeBag()
    let networkService: NetworkService
    
    init(launchesNetworkService: NetworkService) {
        self.networkService = launchesNetworkService
        
        self.launches = networkService.fetchLaunches()
        let response = BehaviorRelay<Response>(value: [])
        self.launches = response.asObservable()
        
        launches
            .withLatestFrom(response)
            .map { $0 }
            .bind(to: response)
            .disposed(by: disposeBag)
    }
}
