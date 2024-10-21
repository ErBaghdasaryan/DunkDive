//
//  BaseRouter.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//
import UIKit
import Combine
import DunkDiveViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
