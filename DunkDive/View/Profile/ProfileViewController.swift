//
//  ProfileViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import WebKit
import SnapKit
import DunkDiveViewModel

final class ProfileViewController: BaseViewController {
    var viewModel: ViewModel?

    private let webView = WKWebView()
    private var url = String()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        view.backgroundColor = .white
        self.webView.backgroundColor = .clear

        setupConstraints()
    }

    private func setupConstraints() {
        self.view.addSubview(webView)

        webView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }
    }

    override func setupViewModel() {
        guard let viewModel = self.viewModel else { return }
        self.url = viewModel.url
        if let url = URL(string: self.url) {
            webView.load(URLRequest(url: url))
        }
    }
}

extension ProfileViewController: IViewModelableController {
    typealias ViewModel = IProfileViewModel
    
}

import SwiftUI

struct ProfileViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let profileViewController = ProfileViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) -> ProfileViewController {
            return profileViewController
        }

        func updateUIViewController(_ uiViewController: ProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) {
        }
    }
}

