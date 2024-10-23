//
//  EditTeamViewModel.swift
//
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IEditTeamViewModel {
    func editTeam(model: TeamModel)
    func deleteTeam(by id: Int)
    var team: TeamModel { get set }
    var players: [PlayerModel] { get set }
    func addPlayer(model: PlayerModel) -> PlayerModel?
    func deletePlayer(by id: Int)
    func getPlayers(by teamId: Int)
}

public class EditTeamViewModel: IEditTeamViewModel {

    private let teamService: ITeamService
    public var team: TeamModel
    public var players: [PlayerModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(teamService: ITeamService, navigationModel: TeamNavigationModel) {
        self.teamService = teamService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.team = navigationModel.model
    }

    public func editTeam(model: TeamModel) {
        do {
            try self.teamService.editTeam(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }

    public func deleteTeam(by id: Int) {
        do {
            try self.teamService.deleteTeam(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }

    public func getPlayers(by teamId: Int) {
        do {
            self.players  = try self.teamService.getPlayers(by: teamId)
        } catch {
            print(error)
        }
    }

    public func addPlayer(model: PlayerModel) -> PlayerModel? {
        do {
            return try self.teamService.addPlayer(model)
        } catch {
            return nil
        }
    }

    public func deletePlayer(by id: Int) {
        do {
            try self.teamService.deletePlayer(byID: id)
        } catch {
            print(error)
        }
    }
}
