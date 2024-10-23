//
//  AddTeamViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IAddTeamViewModel {
    func addTeam(model: TeamModel)
    func deleteTeam(by id: Int)
    func addPlayer(model: PlayerModel) -> PlayerModel?
    func editTeam(model: TeamModel)
    func deletePlayer(by id: Int)
    var team: TeamModel? { get set }
}

public class AddTeamViewModel: IAddTeamViewModel {

    private let teamService: ITeamService
    public var team: TeamModel?

    public init(teamService: ITeamService) {
        self.teamService = teamService
    }

    public func addTeam(model: TeamModel) {
        do {
            self.team = try self.teamService.addTeam(model)
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

    public func deleteTeam(by id: Int) {
        do {
            try self.teamService.deleteTeam(byID: id)
        } catch {
            print(error)
        }
    }

    public func deletePlayer(by id: Int) {
        do {
            try self.teamService.deletePlayer(byID: id)
        } catch {
            print(error)
        }
    }

    public func editTeam(model: TeamModel) {
        do {
            try self.teamService.editTeam(model)
        } catch {
            print(error)
        }
    }
}
