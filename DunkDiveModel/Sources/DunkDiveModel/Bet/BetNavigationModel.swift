//
//  BetNavigationModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import Combine

public final class BetNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: BetModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: BetModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
