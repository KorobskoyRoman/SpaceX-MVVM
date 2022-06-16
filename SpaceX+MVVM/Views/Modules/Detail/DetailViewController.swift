//
//  DetailViewController.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModel
    weak var coordinator: AppCoordinator?
    private lazy var detailView = DetailView()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.launch.name
        view.backgroundColor = .mainWhite()
        setupView()
        setupModel()
    }
}

private extension DetailViewController {
    private func setupView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.clipsToBounds = true
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupModel() {
        detailView.configure(from: viewModel)
    }
}
