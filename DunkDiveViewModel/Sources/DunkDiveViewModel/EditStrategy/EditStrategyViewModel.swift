//
//  EditStrategyViewModel.swift
//
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IEditStrategyViewModel {
    func editStrategy(model: StrategyModel)
    func deleteStrategy(by id: Int)
    var strategy: StrategyModel { get set }
}

public class EditStrategyViewModel: IEditStrategyViewModel {

    private let strategyService: IStrategyService
    public var strategy: StrategyModel
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(strategyService: IStrategyService, navigationModel: StrategyNavigationModel) {
        self.strategyService = strategyService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.strategy = navigationModel.model
    }

    public func editStrategy(model: StrategyModel) {
        do {
            try self.strategyService.editStrategy(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }

    public func deleteStrategy(by id: Int) {
        do {
            try self.strategyService.deleteStrategy(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
