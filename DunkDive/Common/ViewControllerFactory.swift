//
//  ViewControllerFactory.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import Foundation
import Swinject
import DunkDiveViewModel
import DunkDiveModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: - UntilOnboarding
    static func makeUntilOnboardingViewController() -> UntilOnboardingViewController {
        let assembler = Assembler(commonAssemblies + [UntilOnboardingAssembly()])
        let viewController = UntilOnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IUntilOnboardingViewModel.self)
        return viewController
    }

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }

    //MARK: Team
    static func makeTeamViewController() -> TeamViewController {
        let assembler = Assembler(commonAssemblies + [TeamAssembly()])
        let viewController = TeamViewController()
        viewController.viewModel = assembler.resolver.resolve(ITeamViewModel.self)
        return viewController
    }

    static func makeAddTeamViewController() -> AddTeamViewController {
        let assembler = Assembler(commonAssemblies + [AddTeamAssembly()])
        let viewController = AddTeamViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddTeamViewModel.self)
        return viewController
    }

    static func makeEditTeamViewController(navigationModel: TeamNavigationModel) -> EditTeamViewController {
        let assembler = Assembler(commonAssemblies + [EditTeamAssembly()])
        let viewController = EditTeamViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditTeamViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Bet
    static func makeBetViewController() -> BetViewController {
        let assembler = Assembler(commonAssemblies + [BetAssembly()])
        let viewController = BetViewController()
        viewController.viewModel = assembler.resolver.resolve(IBetViewModel.self)
        return viewController
    }

    static func makeAddBetViewController(navigationModel: SubjectNavigationModel) -> AddBetViewController {
        let assembler = Assembler(commonAssemblies + [AddBetAssembly()])
        let viewController = AddBetViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddBetViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeEditBetViewController(navigationModel: BetNavigationModel) -> EditBetViewController {
        let assembler = Assembler(commonAssemblies + [EditBetAssembly()])
        let viewController = EditBetViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditBetViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Strategy
    static func makeStrategyViewController() -> StrategyViewController {
        let assembler = Assembler(commonAssemblies + [StrategyAssembly()])
        let viewController = StrategyViewController()
        viewController.viewModel = assembler.resolver.resolve(IStrategyViewModel.self)
        return viewController
    }

    static func makeAddStrategyViewController(navigationModel: SubjectNavigationModel) -> AddStrategyViewController {
        let assembler = Assembler(commonAssemblies + [AddStrategyAssembly()])
        let viewController = AddStrategyViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddStrategyViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeEditStrategyViewController(navigationModel: StrategyNavigationModel) -> EditStrategyViewController {
        let assembler = Assembler(commonAssemblies + [EditStrategyAssembly()])
        let viewController = EditStrategyViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditStrategyViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    static func makeUsageViewController() -> UsageViewController {
        let viewController = UsageViewController()
        return viewController
    }

    //MARK: Home
    static func makeHomeViewController() -> HomeViewController {
        let assembler = Assembler(commonAssemblies + [HomeAssembly()])
        let viewController = HomeViewController()
        viewController.viewModel = assembler.resolver.resolve(IHomeViewModel.self)
        return viewController
    }

    //MARK: Status
    static func makeStatusViewController() -> StatusViewController {
        let assembler = Assembler(commonAssemblies + [StatusAssembly()])
        let viewController = StatusViewController()
        viewController.viewModel = assembler.resolver.resolve(IStatusViewModel.self)
        return viewController
    }

    //MARK: Profile
    static func makeProfileViewController() -> ProfileViewController {
        let assembler = Assembler(commonAssemblies + [ProfileAssembly()])
        let viewController = ProfileViewController()
        viewController.viewModel = assembler.resolver.resolve(IProfileViewModel.self)
        return viewController
    }
}
