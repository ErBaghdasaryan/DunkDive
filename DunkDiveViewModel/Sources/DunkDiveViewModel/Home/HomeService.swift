//
//  HomeService.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import DunkDiveModel

public protocol IHomeService {
    func getHomeItems() -> [HomePresentationModel]
}

public class HomeService: IHomeService {
    public init() { }

    public func getHomeItems() -> [HomePresentationModel] {
        [
            HomePresentationModel(phoneImage: "firstHome",
                                        title: "Bet on your favorite team"),
            HomePresentationModel(phoneImage: "secondHome",
                                        title: "Rate us in AppStore")
        ]
    }
}
