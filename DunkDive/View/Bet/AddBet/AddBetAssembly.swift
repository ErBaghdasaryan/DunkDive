//
//  AddBetAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveViewModel
import DunkDiveModel
import Swinject
import SwinjectAutoregistration

final class AddBetAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IAddBetViewModel.self, argument: SubjectNavigationModel.self, initializer: AddBetViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IBetService.self, initializer: BetService.init)
    }
}