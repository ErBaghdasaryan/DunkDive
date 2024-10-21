//
//  StrategyViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveModel

public protocol IStrategyViewModel {
    
}

public class StrategyViewModel: IStrategyViewModel {

    private let strategyService: IStrategyService

    public init(strategyService: IStrategyService) {
        self.strategyService = strategyService
    }
}
