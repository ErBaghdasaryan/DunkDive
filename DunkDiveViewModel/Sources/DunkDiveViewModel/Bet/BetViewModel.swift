//
//  BetViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import DunkDiveModel
import Combine

public protocol IBetViewModel {
    func loadData()
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    var bets: [BetModel] { get set }
}

public class BetViewModel: IBetViewModel {

    private let betService: IBetService
    public var bets: [BetModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(betService: IBetService) {
        self.betService = betService
    }

    public func loadData() {
        do {
            self.bets = try self.betService.getBets()
        } catch {
            print(error)
        }
    }
}
