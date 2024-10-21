//
//  BetViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveModel

public protocol IBetViewModel {
    
}

public class BetViewModel: IBetViewModel {

    private let betService: IBetService

    public init(betService: IBetService) {
        self.betService = betService
    }
}
