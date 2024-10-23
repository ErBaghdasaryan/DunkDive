//
//  EditStrategyAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveViewModel
import DunkDiveModel
import Swinject
import SwinjectAutoregistration

final class EditStrategyAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditStrategyViewModel.self, argument: StrategyNavigationModel.self, initializer: EditStrategyViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IStrategyService.self, initializer: StrategyService.init)
    }
}
