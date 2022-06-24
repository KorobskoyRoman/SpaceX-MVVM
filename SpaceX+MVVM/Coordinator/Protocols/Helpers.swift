//
//  Helpers.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 24.06.2022.
//

import UIKit

protocol AuthenticationCoordinator {
    func showAuth(_ navigationController: UINavigationController,
                  _ isLoggedIn: Bool,
                  _ coordinator: AppCoordinator)
}

protocol UserInformationCoordinator {
    func showProfile(_ viewModel: UserInfoViewModel,
                     _ navigationController: UINavigationController,
                     _ coordinator: AppCoordinator)
}
