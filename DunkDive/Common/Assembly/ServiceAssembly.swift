//
//  ServiceAssembly.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import DunkDiveViewModel

public final class ServiceAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.autoregister(IKeychainService.self, initializer: KeychainService.init)
        container.autoregister(IAppStorageService.self, initializer: AppStorageService.init)
        container.autoregister(IValidationService.self, initializer: ValidationService.init)
    }
}
