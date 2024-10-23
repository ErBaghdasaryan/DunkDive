//
//  TeamNavigationModel.swift
//
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import Combine

public final class TeamNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: TeamModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: TeamModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
