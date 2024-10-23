//
//  StrategyModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.10.24.
//
import UIKit

public struct StrategyModel {
    public let id: Int?
    public let image: UIImage
    public let title: String
    public let date: String

    public init(id: Int? = nil, image: UIImage, title: String, date: String) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
