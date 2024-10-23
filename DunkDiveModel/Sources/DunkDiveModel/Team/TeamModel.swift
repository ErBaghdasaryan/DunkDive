//
//  TeamModel.swift
//
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit

public struct TeamModel {
    public let id: Int?
    public let image: UIImage
    public let name: String
    public let country: String

    public init(id: Int? = nil, image: UIImage, name: String, country: String) {
        self.id = id
        self.image = image
        self.name = name
        self.country = country
    }
}
