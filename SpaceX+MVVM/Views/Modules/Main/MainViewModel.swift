//
//  MainViewModel.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import Foundation

class MainViewModel {
    
    var launches: [Result] = []
    private let networkService = NetworkManager()
    private var isLoading = false
    
    var reload: (()->Void)?
    
    var launchesCount: Int {
        launches.count
    }
    
    func launch(at index: Int) -> Result {
        launches[index]
    }
    
    func fetchLaunches() {
        guard !isLoading else { return }
        
        isLoading = true
        networkService.fetchLaunches { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            if result != [Result]() {
                let arr = result[..<20]
                self.launches = Array(arr)
                self.reload?()
                print(self.launches.count)
            }
        }
    }
    
//    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailViewModel {
//
//    }
}

