//
//  BetRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel
import DunkDiveModel

final class BetRouter: BaseRouter {
    static func showAddBetViewController(in navigationController: UINavigationController, navigationModel: SubjectNavigationModel) {
        let viewController = ViewControllerFactory.makeAddBetViewController(navigationModel: navigationModel)
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }

    static func showEditBetViewController(in navigationController: UINavigationController, navigationModel: BetNavigationModel) {
        let viewController = ViewControllerFactory.makeEditBetViewController(navigationModel: navigationModel)
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }
}
