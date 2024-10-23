//
//  StrategyViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveViewModel
import SnapKit
import StoreKit

class StrategyViewController: BaseViewController {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D1016")

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Strategy"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 10
        let totalSpacing = ((numberOfColumns - 1) * spacing) + 10
        let availableWidth = self.view.frame.width - totalSpacing
        let itemWidth = availableWidth / numberOfColumns

        let myLayout = UICollectionViewFlowLayout()
        myLayout.itemSize = CGSize(width: itemWidth, height: 163)
        myLayout.scrollDirection = .vertical
        myLayout.minimumLineSpacing = spacing
        myLayout.minimumInteritemSpacing = spacing
        myLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(EmptyStrategyCollectionViewCell.self)
        collectionView.register(StrategyCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(collectionView)
        setupConstraints()
        makeButtonActions()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.collectionView.reloadData()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadData()
            self.collectionView.reloadData()
        }.store(in: &cancellables)

    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(70)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }
}


extension StrategyViewController: IViewModelableController {
    typealias ViewModel = IStrategyViewModel
}

//MARK: Button Actions
extension StrategyViewController {
    private func makeButtonActions() {
        
    }

    private func editStrategy(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.strategies[index]

        StrategyRouter.showEditStrategyViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }

    private func setupNavigationItems() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let addButton = UIBarButtonItem(image: UIImage(named: "plusHeader"), style: .done, target: self, action: #selector(addStrategy))

        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addStrategy() {
        guard let navigationController = self.navigationController else { return }
        guard let subjecy = self.viewModel?.activateSuccessSubject else { return }

        StrategyRouter.showAddStrategyViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subjecy))
    }
}

extension StrategyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.viewModel?.strategies.count ?? 0
        return count == 0 ? 1 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let count = self.viewModel?.strategies.count ?? 0
        if count == 0 {
            let cell: EmptyStrategyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: StrategyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let strategy = self.viewModel?.strategies[indexPath.row] {
                cell.setup(strategyImage: strategy.image,
                           date: strategy.date,
                           title: strategy.title)
            }

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = self.viewModel?.strategies.count ?? 0

        if count == 0 {
            return CGSize(width: collectionView.frame.width, height: 150)
        } else {
            let numberOfColumns: CGFloat = 2
            let spacing: CGFloat = 10

            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + ((numberOfColumns - 1) * layout.minimumInteritemSpacing)

            let availableWidth = collectionView.frame.width - totalSpacing
            let itemWidth = availableWidth / numberOfColumns

            return CGSize(width: itemWidth, height: 163)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.editStrategy(for: indexPath.row)
    }
}

//MARK: Preview
import SwiftUI

struct StrategyViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let strategyViewController = StrategyViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<StrategyViewControllerProvider.ContainerView>) -> StrategyViewController {
            return strategyViewController
        }

        func updateUIViewController(_ uiViewController: StrategyViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<StrategyViewControllerProvider.ContainerView>) {
        }
    }
}
