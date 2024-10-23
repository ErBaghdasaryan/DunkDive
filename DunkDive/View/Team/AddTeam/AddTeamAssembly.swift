//
//  AddTeamAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveViewModel
import Swinject
import SwinjectAutoregistration

final class AddTeamAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IAddTeamViewModel.self, initializer: AddTeamViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ITeamService.self, initializer: TeamService.init)
    }
}
