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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D1016")

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Bets"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        setupConstraints()
        makeButtonActions()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

    }
}


extension BetViewController: IViewModelableController {
    typealias ViewModel = IBetViewModel
}

//MARK: Button Actions
extension BetViewController {
    private func makeButtonActions() {
        
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
