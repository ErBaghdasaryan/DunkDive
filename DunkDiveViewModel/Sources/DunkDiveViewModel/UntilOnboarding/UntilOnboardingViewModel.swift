//
//  UntilOnboardingViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveModel

public protocol IUntilOnboardingViewModel {
    var skipOnboarding: Bool { get set }
    var skip: Bool { get set }
    var isAlreadyOpened: Bool { get }
    var appStorageService: IAppStorageService { get set }
}

public class UntilOnboardingViewModel: IUntilOnboardingViewModel {

    public var skipOnboarding: Bool {
        get {
            return appStorageService.hasData(for: .skipOnboarding)
        }
        set {
            appStorageService.saveData(key: .skipOnboarding, value: newValue)
        }
    }

    public var skip: Bool {
        get {
            return appStorageService.hasData(for: .alreadyOpened)
        }
        set {
            appStorageService.saveData(key: .alreadyOpened, value: newValue)
        }
    }

    public var isAlreadyOpened: Bool {
        get {
            return appStorageService.getData(key: .isAlreadyOpened)!
        }
    }

    private let untilOnboardingService: IUntilOnboardingService
    public var appStorageService: IAppStorageService

    public init(untilOnboardingService: IUntilOnboardingService, appStorageService: IAppStorageService) {
        self.untilOnboardingService = untilOnboardingService
        self.appStorageService = appStorageService
    }
}

