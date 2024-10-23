//
//  TeamService.swift
//
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveModel
import SQLite

public protocol ITeamService {
    func addTeam(_ model: TeamModel) throws -> TeamModel
    func getTeams() throws -> [TeamModel]
    func deleteTeam(byID id: Int) throws
    func editTeam(_ team: TeamModel) throws
    func addPlayer(_ model: PlayerModel) throws -> PlayerModel
    func getPlayers() throws -> [PlayerModel]
    func getPlayers(by teamId: Int) throws -> [PlayerModel]
    func deletePlayer(byID id: Int) throws
    func editPlayer(_ player: PlayerModel) throws
}

public class TeamService: ITeamService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addTeam(_ model: TeamModel) throws -> TeamModel {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let countryColumn = Expression<String>("country")

        try db.run(teams.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(nameColumn)
            t.column(imageColumn)
            t.column(countryColumn)
        })

        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(teams.insert(
            nameColumn <- model.name,
            imageColumn <- imageData,
            countryColumn <- model.country
        ))

        return TeamModel(id: Int(rowId),
                         image: model.image,
                         name: model.name,
                         country: model.country)
    }

    public func getTeams() throws -> [TeamModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let countryColumn = Expression<String>("country")

        var result: [TeamModel] = []

        for team in try db.prepare(teams) {
            guard let image = UIImage(data: team[imageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedTeam = TeamModel(id: team[idColumn],
                                        image: image,
                                        name: team[nameColumn],
                                        country: team[countryColumn])

            result.append(fetchedTeam)
        }

        return result
    }

    public func deleteTeam(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")

        let teamToDelete = teams.filter(idColumn == id)
        try db.run(teamToDelete.delete())
    }

    public func editTeam(_ team: TeamModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let countryColumn = Expression<String>("country")

        guard let imageData = team.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let teamToUpdate = teams.filter(idColumn == team.id!)
        try db.run(teamToUpdate.update(
            nameColumn <- team.name,
            imageColumn <- imageData,
            countryColumn <- team.country
        ))
    }

    public func addPlayer(_ model: PlayerModel) throws -> PlayerModel {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let nameColumn = Expression<String>("name")
        let positionColumn = Expression<String>("position")

        try db.run(players.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(teamIdColumn)
            t.column(nameColumn)
            t.column(positionColumn)
            t.foreignKey(teamIdColumn, references: Table("Teams"), Expression<Int>("id"), delete: .cascade)
        })

        let rowId = try db.run(players.insert(
            teamIdColumn <- model.teamId,
            nameColumn <- model.name,
            positionColumn <- model.position
        ))

        return PlayerModel(id: Int(rowId),
                           teamId: model.teamId,
                           name: model.name,
                           position: model.position)
    }

    public func getPlayers(by teamId: Int) throws -> [PlayerModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let nameColumn = Expression<String>("name")
        let positionColumn = Expression<String>("position")

        var result: [PlayerModel] = []

        for player in try db.prepare(players.filter(teamIdColumn == teamId)) {

            let fetchedPlayer = PlayerModel(id: player[idColumn],
                                            teamId: player[teamIdColumn],
                                            name: player[nameColumn],
                                            position: player[positionColumn])

            result.append(fetchedPlayer)
        }

        return result
    }

    public func getPlayers() throws -> [PlayerModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let nameColumn = Expression<String>("name")
        let positionColumn = Expression<String>("position")

        var result: [PlayerModel] = []

        for player in try db.prepare(players) {

            let fetchedPlayer = PlayerModel(id: player[idColumn],
                                            teamId: player[teamIdColumn],
                                            name: player[nameColumn],
                                            position: player[positionColumn])

            result.append(fetchedPlayer)
        }

        return result
    }

    public func deletePlayer(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")

        let playerToDelete = players.filter(idColumn == id)
        try db.run(playerToDelete.delete())
    }

    public func editPlayer(_ player: PlayerModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let nameColumn = Expression<String>("name")
        let positionColumn = Expression<String>("position")

        let playerToUpdate = players.filter(idColumn == player.id!)
        try db.run(playerToUpdate.update(
            teamIdColumn <- player.teamId,
            nameColumn <- player.name,
            positionColumn <- player.position
        ))
    }

}
