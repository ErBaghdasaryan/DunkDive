//
//  Setupable.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
