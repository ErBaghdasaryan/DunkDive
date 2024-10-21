//
//  SettingsViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//


import Foundation
import DunkDiveModel

public protocol ISettingsViewModel {
    
}

public class SettingsViewModel: ISettingsViewModel {

    private let settingsService: ISettingsService

    public init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }
}
