//
//  EditTeamAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveViewModel
import DunkDiveModel
import Swinject
import SwinjectAutoregistration

final class EditTeamAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditTeamViewModel.self, argument: TeamNavigationModel.self, initializer: EditTeamViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ITeamService.self, initializer: TeamService.init)
    }
}
