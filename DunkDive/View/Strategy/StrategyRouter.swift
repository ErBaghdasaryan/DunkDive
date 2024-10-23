//
//  StrategyRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel
import DunkDiveModel

final class StrategyRouter: BaseRouter {
    static func showAddStrategyViewController(in navigationController: UINavigationController, navigationModel: SubjectNavigationModel) {
        let viewController = ViewControllerFactory.makeAddStrategyViewController(navigationModel: navigationModel)
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }

    static func showEditStrategyViewController(in navigationController: UINavigationController, navigationModel: StrategyNavigationModel) {
        let viewController = ViewControllerFactory.makeEditStrategyViewController(navigationModel: navigationModel)
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }
}
