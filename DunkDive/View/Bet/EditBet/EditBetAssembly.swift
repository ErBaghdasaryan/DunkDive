//
//  EditBetAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveViewModel
import DunkDiveModel
import Swinject
import SwinjectAutoregistration

final class EditBetAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditBetViewModel.self, argument: BetNavigationModel.self, initializer: EditBetViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IBetService.self, initializer: BetService.init)
    }
}
