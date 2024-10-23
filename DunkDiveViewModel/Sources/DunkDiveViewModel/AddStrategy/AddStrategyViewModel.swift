//
//  AddStrategyViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IAddStrategyViewModel {
    func addStrategy(model: StrategyModel)
}

public class AddStrategyViewModel: IAddStrategyViewModel {

    private let strategyService: IStrategyService
    public var strategies: [StrategyModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(strategyService: IStrategyService, navigationModel: SubjectNavigationModel) {
        self.strategyService = strategyService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func addStrategy(model: StrategyModel) {
        do {
            _ = try self.strategyService.addStrategy(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
