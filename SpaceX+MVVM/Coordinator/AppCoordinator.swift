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
    
    private lazy var authCoordinator = AuthCoordinator()
    private lazy var userInfoCoordinator = UserInfoCoordinator()
    private lazy var mainScreenCoordinator = MainscreenCoordinator()
    
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
        authCoordinator.showAuth(navigationController, isLoggedIn, self)
    }
    
    func showMain() {
        let viewModel = MainViewModel()
        mainScreenCoordinator.showMain(viewModel, self, isLoggedIn, navigationController, window)
    }
    
    func showDetail(_ viewModel: Result) {
        let viewModel = DetailViewModel(launch: viewModel)
        let vc = DetailViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfile(_ viewModel: UserInfoViewModel) {
        userInfoCoordinator.showProfile(viewModel, navigationController, self)
    }
}
