//
//  MainScreenCoordinator.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 04.07.2022.
//

import Foundation
import UIKit

class MainscreenCoordinator: MainScreenCoordinator {
    func showMain(_ viewModel: MainViewModel, _ coordinator: AppCoordinator, _ isLoggedIn: Bool, _ navigationController: UINavigationController, _ window: UIWindow) {
        let viewModel = MainViewModel()
        let vc = MainViewController(viewModel: viewModel)
        vc.coordinator = coordinator
        let authVm = AuthViewModel()
        let authVc = AuthViewController(viewModel: authVm)
        navigationController.pushViewController(vc, animated: true)
        navigationController.viewControllers = [vc]
        window.rootViewController = isLoggedIn ? navigationController : authVc
    }
}
