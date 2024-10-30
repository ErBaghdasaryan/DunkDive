//
//  StatusRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel

final class StatusRouter: BaseRouter {
    static func showProfileViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeProfileViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
