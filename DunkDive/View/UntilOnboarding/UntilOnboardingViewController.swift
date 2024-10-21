//
//  UntilOnboardingViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveViewModel
import SnapKit

class UntilOnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let logoImage = UIImageView(image: .init(named: "appLogo"))
    private let progressView = UIProgressView(progressViewStyle: .default)
    private var progress: Float = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#151515")

        progressView.progressTintColor = UIColor(hex: "#A20027")
        progressView.trackTintColor = UIColor(hex: "#1A242D")
        progressView.layer.cornerRadius = 25

        self.view.addSubview(logoImage)
        self.view.addSubview(progressView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

        logoImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(276)
            view.centerX.equalToSuperview()
            view.height.equalTo(168)
            view.width.equalTo(157)
        }

        progressView.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(120)
            view.centerX.equalToSuperview()
            view.height.equalTo(6)
            view.width.equalTo(190)
        }
    }
}


extension UntilOnboardingViewController: IViewModelableController {
    typealias ViewModel = IUntilOnboardingViewModel
}

//MARK: Progress View
extension UntilOnboardingViewController {
    private func startLoading() {
        progressView.progress = 0.0
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }

    @objc private func updateProgress(timer: Timer) {
        guard let navigationController = self.navigationController else { return }
        if progressView.progress < 1.0 {
            if self.progress < 100  {
                self.progress += 1
            }
            UIView.animate(withDuration: 1) {
                self.progressView.progress += 0.01
            }
        } else {
            timer.invalidate()
            goToNextPage()
        }
    }

    private func goToNextPage() {
        guard let navigationController = self.navigationController else { return }
        guard var viewModel = self.viewModel else { return }
        if viewModel.appStorageService.hasData(for: .skipOnboarding) {
            UntilOnboardingRouter.showOnboardingViewController(in: navigationController)
            #warning("ShowTABBAR")
        } else {
            viewModel.skipOnboarding = true
            UntilOnboardingRouter.showOnboardingViewController(in: navigationController)
        }
    }
}

//MARK: Preview
import SwiftUI

struct UntilOnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let untilOnboardingViewController = UntilOnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) -> UntilOnboardingViewController {
            return untilOnboardingViewController
        }

        func updateUIViewController(_ uiViewController: UntilOnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
