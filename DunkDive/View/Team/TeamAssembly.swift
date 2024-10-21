//
//  TeamAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveViewModel
import Swinject
import SwinjectAutoregistration

final class TeamAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ITeamViewModel.self, initializer: TeamViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ITeamService.self, initializer: TeamService.init)
    }
}
