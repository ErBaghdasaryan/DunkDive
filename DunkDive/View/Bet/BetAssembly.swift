//
//  BetAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveViewModel
import Swinject
import SwinjectAutoregistration

final class BetAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IBetViewModel.self, initializer: BetViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IBetService.self, initializer: BetService.init)
    }
}
