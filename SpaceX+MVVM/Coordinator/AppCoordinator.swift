//
//  AppCoordinator.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var isLoggedIn: Bool = false
    
    var navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        if isLoggedIn {
            showMain()
            isLoggedIn.toggle()
        } else {
            showAuth()
        }
    }
    
    func showAuth() {
        let viewModel = AuthViewModel()
        let vc = AuthViewController(viewModel: viewModel)
        viewModel.isLoggedIn = isLoggedIn
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMain() {
        let viewModel = MainViewModel()
        let vc = MainViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.viewControllers.removeLast() // визуальный баг из-за этого
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetail(_ viewModel: Result) {
        let viewModel = DetailViewModel(launch: viewModel)
        let vc = DetailViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfile(_ viewModel: UserInfoViewModel) {
        let viewModel = UserInfoViewModel()
        let vc = UserInfoViewController(viewModel: viewModel)
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
