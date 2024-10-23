//
//  TabBarRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel

final class TabBarRouter: BaseRouter {
    static func showAddTeamViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeAddTeamViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }
}
