//
//  HomeViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import DunkDiveModel

public protocol IHomeViewModel {
    var homeItems: [HomePresentationModel] { get set }
    func loadData()
}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService

    public var homeItems: [HomePresentationModel] = []

    public init(homeService: IHomeService) {
        self.homeService = homeService
    }

    public func loadData() {
        homeItems = homeService.getHomeItems()
    }
}
