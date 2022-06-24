//
//  UserInfoCoordinator.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 24.06.2022.
//

import UIKit

class UserInfoCoordinator: UserInformationCoordinator {
    func showProfile(_ viewModel: UserInfoViewModel, _ navigationController: UINavigationController, _ coordinator: AppCoordinator) {
        let viewModel = UserInfoViewModel()
        let vc = UserInfoViewController(viewModel: viewModel)
        vc.coordinator = coordinator
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
