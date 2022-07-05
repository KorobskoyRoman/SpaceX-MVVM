//
//  AuthCoordinator.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 23.06.2022.
//

import UIKit

class AuthCoordinator: AuthenticationCoordinator {
    func showAuth(_ navigationController: UINavigationController,_ isLoggedIn: Bool,_ coordinator: AppCoordinator) {
        let viewModel = AuthViewModel()
        let vc = AuthViewController(viewModel: viewModel)
        viewModel.isLoggedIn = isLoggedIn
        vc.coordinator = coordinator
        vc.viewModel = viewModel
        if navigationController.viewControllers.count != 0 {
            navigationController.viewControllers.removeAll()
        }
        navigationController.pushViewController(vc, animated: true)
    }
}
