//
//  SettingsRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel

final class SettingsRouter: BaseRouter {
    static func showUsageViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeUsageViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }
}
