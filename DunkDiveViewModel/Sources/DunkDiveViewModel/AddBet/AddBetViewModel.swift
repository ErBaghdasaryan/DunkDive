//
//  AddBetViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IAddBetViewModel {
    func loadData()
    var teams: [TeamModel] { get set }
    func addBet(model: BetModel)
}

public class AddBetViewModel: IAddBetViewModel {

    private let betService: IBetService
    public var teams: [TeamModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(betService: IBetService, navigationModel: SubjectNavigationModel) {
        self.betService = betService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func loadData() {
        do {
            self.teams = try self.betService.getTeams()
        } catch {
            print(error)
        }
    }

    public func addBet(model: BetModel) {
        do {
            _ = try self.betService.addBet(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
