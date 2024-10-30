//
//  ResponseModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation

public struct ResponseModel: Codable {
    public let pastedTwice: Bool
    public let collapsible: String

    enum CodingKeys: String, CodingKey {
        case pastedTwice = "pastedTwice"
        case collapsible
    }
}
