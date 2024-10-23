//
//  BetViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveViewModel
import SnapKit
import StoreKit

class BetViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D1016")

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Bets"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(tableView)
        setupConstraints()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadData()
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(TeamEmptyTableViewCell.self)
        self.tableView.register(BetTableViewCell.self)
    }
}


extension BetViewController: IViewModelableController {
    typealias ViewModel = IBetViewModel
}

//MARK: Button Actions
extension BetViewController {
    private func makeButtonActions() {
        
    }

    private func setupNavigationItems() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let addButton = UIBarButtonItem(image: UIImage(named: "plusHeader"), style: .done, target: self, action: #selector(addBet))

        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addBet() {
        guard let navigationController = self.navigationController else { return }
        guard let subjecy = self.viewModel?.activateSuccessSubject else { return }

        BetRouter.showAddBetViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subjecy))
    }

    private func editBet(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.bets[index]

        BetRouter.showEditBetViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }
}

//MARK: TableView Delegate & Data source
extension BetViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.bets.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel?.bets.isEmpty ?? true {
            let cell: TeamEmptyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: "To add a bet click a button above")
            return cell
        } else {
            let cell: BetTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.bets[indexPath.row] {
                cell.setup(model: model)
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.bets.isEmpty ?? true {
            return 48
        } else {
            return 127
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.editBet(for: indexPath.row)
    }
}

//MARK: Preview
import SwiftUI

struct BetViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let betViewController = BetViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<BetViewControllerProvider.ContainerView>) -> BetViewController {
            return betViewController
        }

        func updateUIViewController(_ uiViewController: BetViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<BetViewControllerProvider.ContainerView>) {
        }
    }
}
