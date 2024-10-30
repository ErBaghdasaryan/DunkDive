//
//  HomePresentationModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation

public struct HomePresentationModel {
    public let phoneImage: String
    public let title: String

    public init(phoneImage: String, title: String) {
        self.phoneImage = phoneImage
        self.title = title
    }
}
