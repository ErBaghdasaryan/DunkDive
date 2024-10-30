//
//  HomeRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel

final class HomeRouter: BaseRouter {
    static func showStatusViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeStatusViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
