//
//  PlayerModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit

public struct PlayerModel {
    public let id: Int?
    public let teamId: Int
    public let name: String
    public let position: String

    public init(id: Int? = nil, teamId: Int, name: String, position: String) {
        self.id = id
        self.teamId = teamId
        self.name = name
        self.position = position
    }
}
