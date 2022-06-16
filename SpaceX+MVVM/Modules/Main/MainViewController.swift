//
//  MainViewController.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    private var viewModel: LaunchesViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init(viewModel: LaunchesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .systemRed
        
        viewModel.outputs.launches
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items) { [weak self] tableView, row, launch in
                guard let self = self else { return UITableViewCell() }
                let cell = self.tableView.dequeueCell(cellType: MainCell.self, for: IndexPath(row: row, section: 0))
                //configure
                cell.update(with: launch)
                print(launch)
                return cell
            }
            .disposed(by: disposeBag)
        
//        tableView.rx.modelSelected(Result.self)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] in
//                let detailViewModel =
//            })
        print(viewModel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    private func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseId)
        view.addSubview(tableView)
    }
}

