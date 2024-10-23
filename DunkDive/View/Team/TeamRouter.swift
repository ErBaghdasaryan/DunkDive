//
//  TeamRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import UIKit
import DunkDiveViewModel
import DunkDiveModel

final class TeamRouter: BaseRouter {
    static func showEditTeamViewController(in navigationController: UINavigationController, navigationModel: TeamNavigationModel) {
        let viewController = ViewControllerFactory.makeEditTeamViewController(navigationModel: navigationModel)
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }
}
