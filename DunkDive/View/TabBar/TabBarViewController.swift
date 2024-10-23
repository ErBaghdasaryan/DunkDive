//
//  TabBarViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveViewModel
import SnapKit

class TabBarViewController: UITabBarController {

    private let floatingButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupFloatingButton()
    }

    private func setupViewControllers() {
        lazy var teamViewController = self.createNavigation(title: "Teams",
                                                            image: "team",
                                                            vc: ViewControllerFactory.makeTeamViewController())

        lazy var betViewController = self.createNavigation(title: "Bets",
                                                                image: "bet",
                                                                vc: ViewControllerFactory.makeBetViewController())

        lazy var strategyViewController = self.createNavigation(title: "Strategy",
                                                             image: "strategy",
                                                             vc: ViewControllerFactory.makeStrategyViewController())

        lazy var settingsViewController = self.createNavigation(title: "Settings",
                                                                image: "settings",
                                                                vc: ViewControllerFactory.makeSettingsViewController())

        self.setViewControllers([teamViewController, betViewController, createSpacer(), strategyViewController, settingsViewController], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPageToTeam), name: Notification.Name("ResetCompleted"), object: nil)

        betViewController.delegate = self
        teamViewController.delegate = self
        strategyViewController.delegate = self
        settingsViewController.delegate = self
    }

    private func setupFloatingButton() {
        floatingButton.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        floatingButton.tintColor = .white
        floatingButton.backgroundColor = UIColor(hex: "#EF441D")
        floatingButton.layer.cornerRadius = 30
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        floatingButton.layer.shadowRadius = 6

        floatingButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)

        self.view.addSubview(floatingButton)

        floatingButton.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.centerX.equalTo(self.tabBar.snp.centerX)
            make.bottom.equalTo(self.tabBar.snp.bottom).inset(44)
        }
    }

    @objc func setCurrentPageToTeam() {
        self.selectedIndex = 0
    }

    @objc func addTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.showAddTeamViewController(in: navigationController)
    }

    private func createSpacer() -> UIViewController {
        let spacerVC = UIViewController()
        spacerVC.tabBarItem.isEnabled = false
        return spacerVC
    }

    private func createNavigation(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        self.tabBar.backgroundColor = UIColor(hex: "#0D1016")
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemWidth = 48
        self.tabBar.itemSpacing = 30

        let unselectedImage = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: image)?.withTintColor(.white, renderingMode: .alwaysTemplate)

        navigation.tabBarItem.image = UIImage(named: image)
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.tabBarItem.title = title

        let nonselectedTitleColor: UIColor = UIColor(hex: "#80858E")!
        let selectedTitleColor: UIColor = UIColor(hex: "#EF441D")!

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: nonselectedTitleColor
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedTitleColor
        ]

        navigation.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        navigation.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)

        self.tabBar.tintColor = UIColor(hex: "#EF441D")!
        self.tabBar.unselectedItemTintColor = UIColor(hex: "#80858E")!
        self.tabBar.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        self.tabBar.layer.borderWidth = 1


        return navigation
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }
}

//MARK: Navigation & TabBar Hidden
extension TabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}

//MARK: Preview
import SwiftUI

struct TabBarViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let tabBarViewController = TabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) -> TabBarViewController {
            return tabBarViewController
        }

        func updateUIViewController(_ uiViewController: TabBarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) {
        }
    }
}

