//
//  StatusViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import DunkDiveViewModel
import SnapKit
import StoreKit

class StatusViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let topView = UIImageView(image: .init(named: "statusImage"))
    private let bottomView = UIView()
    private let header = UILabel(text: "Enable notification",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let continueButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#0D1016")

        self.bottomView.backgroundColor = UIColor(hex: "#0D1016")

        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        header.textAlignment = .center
        header.numberOfLines = 2

        self.continueButton.setTitle("Enable", for: .normal)
        self.continueButton.layer.cornerRadius = 8
        self.continueButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.continueButton.setTitleColor(.white, for: .normal)
        self.continueButton.backgroundColor = UIColor(hex: "#EF441D")

        self.view.addSubview(bottomView)
        self.view.addSubview(topView)
        self.view.addSubview(header)
        self.view.addSubview(continueButton)
        setupConstraints()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(209)
        }

        topView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview().inset(209)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(44)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(54)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }
}

//MARK: Make buttons actions
extension StatusViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
    }

    @objc func continueButtonTaped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Enabled",
                                                message: "You will now receive notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            StatusRouter.showProfileViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    private func setupNavigationItems() {
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "customClose"), style: .done, target: self, action: #selector(closeTapped))

        navigationItem.rightBarButtonItem = closeButton
    }

    @objc func closeTapped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Disabled",
                                                message: "You will now disable notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            StatusRouter.showProfileViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension StatusViewController: IViewModelableController {
    typealias ViewModel = IStatusViewModel
}

//MARK: Preview
import SwiftUI

struct StatusViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let statusViewController = StatusViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<StatusViewControllerProvider.ContainerView>) -> StatusViewController {
            return statusViewController
        }

        func updateUIViewController(_ uiViewController: StatusViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<StatusViewControllerProvider.ContainerView>) {
        }
    }
}
