//
//  UserInfoViewController.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation
import UIKit

class UserInfoViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var viewModel: UserInfoViewModel
    let userView = UserInfoView()
    
    init(viewModel: UserInfoViewModel) {
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
        view.addSubview(userView)
        userView.frame = view.bounds
    }
}
