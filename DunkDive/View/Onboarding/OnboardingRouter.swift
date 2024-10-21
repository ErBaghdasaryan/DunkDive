//
//  OnboardingRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel

final class OnboardingRouter: BaseRouter {
    static func showTabBarViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
