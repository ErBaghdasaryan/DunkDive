//
//  ProfileAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import DunkDiveViewModel

final class ProfileAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IProfileViewModel.self, initializer: ProfileViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IProfileService.self, initializer: ProfileService.init)
    }
}

