//
//  StatusViewModel.swift
//
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import DunkDiveModel

public protocol IStatusViewModel {

}

public class StatusViewModel: IStatusViewModel {

    private let statusService: IStatusService

    public init(statusService: IStatusService) {
        self.statusService = statusService
    }
}
