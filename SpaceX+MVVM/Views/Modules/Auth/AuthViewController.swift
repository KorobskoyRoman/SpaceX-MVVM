//
//  AuthViewController.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {
    
    let authView = AuthView()
    var viewModel: AuthViewModel
    weak var coordinator: AppCoordinator?
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(authView)
        authView.frame = view.bounds
        authView.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
}

extension AuthViewController {
    @objc private func signInTapped() {
        viewModel.loginButtonPressed(email: authView.emailTextField.text ?? "",
                                     password: authView.passwordTextField.text ?? "")
        if viewModel.isLoggedIn {
            coordinator?.isLoggedIn = viewModel.isLoggedIn
            coordinator?.showMain()
        }
    }
}

