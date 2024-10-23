//
//  TeamViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol ITeamViewModel {
    func loadData()
    var teams: [TeamModel] { get set }
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class TeamViewModel: ITeamViewModel {

    private let teamService: ITeamService
    public var teams: [TeamModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(teamService: ITeamService) {
        self.teamService = teamService
    }

    public func loadData() {
        do {
            self.teams = try self.teamService.getTeams()
        } catch {
            print(error)
        }
    }
}
