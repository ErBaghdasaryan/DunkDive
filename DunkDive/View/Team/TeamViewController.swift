//
//  TeamViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveViewModel
import SnapKit
import StoreKit

class TeamViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D1016")

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Teams"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(tableView)
        setupConstraints()
        makeButtonActions()
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
        self.tableView.register(TeamTableViewCell.self)
    }
}


extension TeamViewController: IViewModelableController {
    typealias ViewModel = ITeamViewModel
}

//MARK: Button Actions
extension TeamViewController {
    private func makeButtonActions() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Notification.Name("TeamAdded"), object: nil)
    }

    @objc func handleNotification() {
        self.viewModel?.loadData()
        self.tableView.reloadData()
    }

    private func editTeam(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.teams[index]

        TeamRouter.showEditTeamViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }
}

//MARK: TableView Delegate & Data source
extension TeamViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.teams.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel?.teams.isEmpty ?? true {
            let cell: TeamEmptyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: "You can always add a team with the plus icon below")
            return cell
        } else {
            let cell: TeamTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.teams[indexPath.row] {
                cell.setup(teamImage: model.image,
                           name: model.name,
                           country: model.country)
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.teams.isEmpty ?? true {
            return 48
        } else {
            return 96
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.editTeam(for: indexPath.row)
    }
}

//MARK: Preview
import SwiftUI

struct TeamViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let teamViewController = TeamViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TeamViewControllerProvider.ContainerView>) -> TeamViewController {
            return teamViewController
        }

        func updateUIViewController(_ uiViewController: TeamViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TeamViewControllerProvider.ContainerView>) {
        }
    }
}
