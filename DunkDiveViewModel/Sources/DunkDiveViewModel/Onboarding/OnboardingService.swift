//
//  OnboardingService.swift
//
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveModel

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentation]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentation] {
        [
            OnboardingPresentation(phoneImage: "onboarding1",
                                        title: "Add your favorite teams"),
            OnboardingPresentation(phoneImage: "onboarding2",
                                        title: "Keep all bets in one app"),
            OnboardingPresentation(phoneImage: "onboarding3",
                                        title: "Write your strategies")
        ]
    }
}
