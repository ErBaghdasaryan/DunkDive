//
//  BetService.swift
//
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveModel
import SQLite

public protocol IBetService {
    func addBet(_ model: BetModel) throws -> BetModel
    func getBets() throws -> [BetModel]
    func getBets(by teamId: Int) throws -> [BetModel]
    func deleteBet(byID id: Int) throws
    func editBet(_ bet: BetModel) throws
    func getTeams() throws -> [TeamModel]
}

public class BetService: IBetService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addBet(_ model: BetModel) throws -> BetModel {
        let db = try Connection("\(path)/db.sqlite3")
        let bets = Table("Bets")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let teamNameColumn = Expression<String>("teamName")
        let teamImageColumn = Expression<Data>("teamImage")
        let dateColumn = Expression<String>("date")
        let oddsColumn = Expression<String>("odds")
        let stakeColumn = Expression<String>("stake")
        let winMoneyColumn = Expression<String>("winMoney")
        let isWinColumn = Expression<Bool>("isWine")

        try db.run(bets.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(teamIdColumn)
            t.column(teamNameColumn)
            t.column(teamImageColumn)
            t.column(dateColumn)
            t.column(oddsColumn)
            t.column(stakeColumn)
            t.column(winMoneyColumn)
            t.column(isWinColumn)
            t.foreignKey(teamIdColumn, references: Table("Teams"), Expression<Int>("id"), delete: .cascade)
        })

        guard let imageData = model.teamImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(bets.insert(
            teamIdColumn <- model.teamId,
            teamNameColumn <- model.teamName,
            teamImageColumn <- imageData,
            dateColumn <- model.date,
            oddsColumn <- model.odds,
            stakeColumn <- model.stake,
            winMoneyColumn <- model.winMoney,
            isWinColumn <- model.isWin
        ))

        return BetModel(id: Int(rowId),
                        teamId: model.teamId,
                        teamName: model.teamName,
                        teamImage: model.teamImage,
                        date: model.date,
                        odds: model.odds,
                        stake: model.stake,
                        winMoney: model.winMoney,
                        isWin: model.isWin)
    }

    public func getBets(by teamId: Int) throws -> [BetModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let bets = Table("Bets")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let teamNameColumn = Expression<String>("teamName")
        let teamImageColumn = Expression<Data>("teamImage")
        let dateColumn = Expression<String>("date")
        let oddsColumn = Expression<String>("odds")
        let stakeColumn = Expression<String>("stake")
        let winMoneyColumn = Expression<String>("winMoney")
        let isWinColumn = Expression<Bool>("isWine")

        var result: [BetModel] = []

        for bet in try db.prepare(bets.filter(teamIdColumn == teamId)) {
            guard let image = UIImage(data: bet[teamImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedBet = BetModel(id: bet[idColumn],
                                      teamId: bet[teamIdColumn],
                                      teamName: bet[teamNameColumn],
                                      teamImage: image,
                                      date: bet[dateColumn],
                                      odds: bet[oddsColumn],
                                      stake: bet[stakeColumn],
                                      winMoney: bet[winMoneyColumn],
                                      isWin: bet[isWinColumn])

            result.append(fetchedBet)
        }

        return result
    }

    public func getBets() throws -> [BetModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let bets = Table("Bets")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let teamNameColumn = Expression<String>("teamName")
        let teamImageColumn = Expression<Data>("teamImage")
        let dateColumn = Expression<String>("date")
        let oddsColumn = Expression<String>("odds")
        let stakeColumn = Expression<String>("stake")
        let winMoneyColumn = Expression<String>("winMoney")
        let isWinColumn = Expression<Bool>("isWine")

        var result: [BetModel] = []

        for bet in try db.prepare(bets) {
            guard let image = UIImage(data: bet[teamImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedBet = BetModel(id: bet[idColumn],
                                      teamId: bet[teamIdColumn],
                                      teamName: bet[teamNameColumn],
                                      teamImage: image,
                                      date: bet[dateColumn],
                                      odds: bet[oddsColumn],
                                      stake: bet[stakeColumn],
                                      winMoney: bet[winMoneyColumn],
                                      isWin: bet[isWinColumn])

            result.append(fetchedBet)
        }

        return result
    }

    public func deleteBet(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let bets = Table("Bets")
        let idColumn = Expression<Int>("id")

        let betToDelete = bets.filter(idColumn == id)
        try db.run(betToDelete.delete())
    }

    public func editBet(_ bet: BetModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let bets = Table("Bets")
        let idColumn = Expression<Int>("id")
        let teamIdColumn = Expression<Int>("teamId")
        let teamNameColumn = Expression<String>("teamName")
        let teamImageColumn = Expression<Data>("teamImage")
        let dateColumn = Expression<String>("date")
        let oddsColumn = Expression<String>("odds")
        let stakeColumn = Expression<String>("stake")
        let winMoneyColumn = Expression<String>("winMoney")
        let isWinColumn = Expression<Bool>("isWine")

        guard let imageData = bet.teamImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let betToUpdate = bets.filter(idColumn == bet.id!)
        try db.run(betToUpdate.update(
            teamIdColumn <- bet.teamId,
            teamNameColumn <- bet.teamName,
            teamImageColumn <- imageData,
            dateColumn <- bet.date,
            oddsColumn <- bet.odds,
            stakeColumn <- bet.stake,
            winMoneyColumn <- bet.winMoney,
            isWinColumn <- bet.isWin
        ))
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
}
