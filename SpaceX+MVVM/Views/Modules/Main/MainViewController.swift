//
//  MainViewController.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import UIKit

class MainViewController: UIViewController {

    private var tableView: UITableView!
    private lazy var userInfoBarButton = createCustomButton(selector: #selector(userInfoBarButtonTapped), image: "person.fill")
    
    weak var coordinator: AppCoordinator?
    private var viewModel: MainViewModel
    private var userModel = UserInfoViewModel()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        reload()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchLaunches()
        print(viewModel.launchesCount)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    private func reload() {
        viewModel.reload = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        title = "titleMainVC".localized(tableName: "MainVC")
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .mainWhite()
        navigationItem.rightBarButtonItem = userInfoBarButton
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.showDetail(viewModel.launches[indexPath.row])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launchesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.reuseId, for: indexPath) as! MainCell
        cell.configure(from: viewModel, and: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MainViewController {
    @objc private func userInfoBarButtonTapped() {
        coordinator?.showProfile(userModel)
    }
}
