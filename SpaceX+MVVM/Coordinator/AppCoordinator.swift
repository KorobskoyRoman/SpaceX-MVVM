//
//  AppCoordinator.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
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
        
        showMain()
    }
    
    func showMain() {
        let vc = MainViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
