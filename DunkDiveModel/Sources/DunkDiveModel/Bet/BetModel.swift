//
//  BetModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit

public struct BetModel {
    public let id: Int?
    public let teamId: Int
    public let teamName: String
    public let teamImage: UIImage
    public let date: String
    public let odds: String
    public let stake: String
    public let winMoney: String
    public let isWin: Bool

    public init(id: Int? = nil, teamId: Int, teamName: String, teamImage: UIImage, date: String, odds: String, stake: String, winMoney: String, isWin: Bool) {
        self.id = id
        self.teamId = teamId
        self.teamName = teamName
        self.teamImage = teamImage
        self.date = date
        self.odds = odds
        self.stake = stake
        self.winMoney = winMoney
        self.isWin = isWin
    }
}
