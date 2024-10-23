//
//  StrategyViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IStrategyViewModel {
    func loadData()
    var strategies: [StrategyModel] { get set }
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class StrategyViewModel: IStrategyViewModel {

    private let strategyService: IStrategyService
    public var strategies: [StrategyModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(strategyService: IStrategyService) {
        self.strategyService = strategyService
    }

    public func loadData() {
        do {
            self.strategies = try self.strategyService.getStrategies()
        } catch {
            print(error)
        }
    }
}
