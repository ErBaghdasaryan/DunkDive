//
//  StatusAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import DunkDiveViewModel
import Swinject
import SwinjectAutoregistration

final class StatusAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IStatusViewModel.self, initializer: StatusViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IStatusService.self, initializer: StatusService.init)
    }
}
