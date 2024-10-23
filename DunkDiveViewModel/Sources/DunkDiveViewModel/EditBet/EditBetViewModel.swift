//
//  EditBetViewModel.swift
//
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IEditBetViewModel {
    func loadData()
    var teams: [TeamModel] { get set }
    var bet: BetModel { get set }
    func editBet(model: BetModel)
    func deleteBet(by id: Int)
}

public class EditBetViewModel: IEditBetViewModel {

    private let betService: IBetService
    public var teams: [TeamModel] = []
    public var bet: BetModel
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(betService: IBetService, navigationModel: BetNavigationModel) {
        self.betService = betService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.bet = navigationModel.model
    }

    public func loadData() {
        do {
            self.teams = try self.betService.getTeams()
        } catch {
            print(error)
        }
    }

    public func editBet(model: BetModel) {
        do {
            try self.betService.editBet(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }

    public func deleteBet(by id: Int) {
        do {
            try self.betService.deleteBet(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
