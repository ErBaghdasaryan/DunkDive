//
//  ProfileViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import DunkDiveModel

public protocol IProfileViewModel {
    var url: String { get }
    var appStorageService: IAppStorageService { get set }
}

public class ProfileViewModel: IProfileViewModel {

    public var url: String {
        get {
            return appStorageService.getData(key: .webUrl) ?? ""
        }
    }

    private let profileService: IProfileService
    public var appStorageService: IAppStorageService

    public init(profileService: IProfileService,
                appStorageService: IAppStorageService) {
        self.profileService = profileService
        self.appStorageService = appStorageService
    }
}
