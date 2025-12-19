//
//  MainTabBarAssembly.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import Foundation
import UIKit

enum MainTabBarAssembly {
    
    static func build(
        router: MainRoutingLogic,
        settingsRepository: SettingsRepositoryLogic
    ) -> UIViewController {
        let viewModel = MainTabBarModel(
            router: router,
            settingsRepository: settingsRepository
        )
        let viewController = MainTabBar(viewModel: viewModel)
        
        return viewController
    }
}
