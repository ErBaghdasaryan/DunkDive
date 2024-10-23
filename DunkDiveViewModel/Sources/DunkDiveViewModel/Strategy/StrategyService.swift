//
//  StrategyService.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveModel
import SQLite

public protocol IStrategyService {
    func addStrategy(_ model: StrategyModel) throws -> StrategyModel
    func getStrategies() throws -> [StrategyModel]
    func deleteStrategy(byID id: Int) throws
    func editStrategy(_ strategy: StrategyModel) throws
}

public class StrategyService: IStrategyService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addStrategy(_ model: StrategyModel) throws -> StrategyModel {
        let db = try Connection("\(path)/db.sqlite3")
        let strategies = Table("Strategies")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let titleColumn = Expression<String>("title")
        let dateColumn = Expression<String>("date")

        try db.run(strategies.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(dateColumn)
            t.column(imageColumn)
            t.column(titleColumn)
        })

        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(strategies.insert(
            dateColumn <- model.date,
            imageColumn <- imageData,
            titleColumn <- model.title
        ))

        return StrategyModel(id: Int(rowId),
                             image: model.image,
                             title: model.title,
                             date: model.date)
    }

    public func getStrategies() throws -> [StrategyModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let strategies = Table("Strategies")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let titleColumn = Expression<String>("title")
        let dateColumn = Expression<String>("date")

        var result: [StrategyModel] = []

        for strategy in try db.prepare(strategies) {
            guard let image = UIImage(data: strategy[imageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedStrategy = StrategyModel(id: strategy[idColumn],
                                                image: image,
                                                title: strategy[titleColumn],
                                                date: strategy[dateColumn])

            result.append(fetchedStrategy)
        }

        return result
    }

    public func deleteStrategy(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let strategies = Table("Strategies")
        let idColumn = Expression<Int>("id")

        let strategyToDelete = strategies.filter(idColumn == id)
        try db.run(strategyToDelete.delete())
    }

    public func editStrategy(_ strategy: StrategyModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let strategies = Table("Strategies")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let titleColumn = Expression<String>("title")
        let dateColumn = Expression<String>("date")

        guard let imageData = strategy.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let strategyToUpdate = strategies.filter(idColumn == strategy.id!)
        try db.run(strategyToUpdate.update(
            dateColumn <- strategy.date,
            imageColumn <- imageData,
            titleColumn <- strategy.title
        ))
    }

}
