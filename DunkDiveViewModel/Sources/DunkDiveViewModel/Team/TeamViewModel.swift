//
//  TeamViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveModel

public protocol ITeamViewModel {
    
}

public class TeamViewModel: ITeamViewModel {

    private let teamService: ITeamService

    public init(teamService: ITeamService) {
        self.teamService = teamService
    }
}
