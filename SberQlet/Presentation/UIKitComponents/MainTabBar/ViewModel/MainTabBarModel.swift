//
//  MainTabViewModel.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import UIKit

final class MainTabBarModel {
    
    private enum Constants {
        static let firstTabBarItemTitle = "Home"
        static let firstTabBarItemImage = "house"
        static let firstTabBarItemSelectedImage = "house.fill"
        
        static let secondTabBarItemTitle = "Rating"
        static let secondTabBarItemImage = "chart.line.text.clipboard"
        static let secondTabBarItemSelectedImage = "chart.line.text.clipboard.fill"
    }
    
    private let router: MainRoutingLogic
    
    private let settingsRepository: SettingsRepositoryLogic
    
    private let statisticsManager: CardsStatisticsManagerLogic
    
    init(
        router: MainRoutingLogic,
        settingsRepository: SettingsRepositoryLogic,
        statisticsManager: CardsStatisticsManagerLogic
    ) {
        self.router = router
        self.settingsRepository = settingsRepository
        self.statisticsManager = statisticsManager
    }
    
    func setupViewControllers() -> [UIViewController] {
        let main = MainScreenAssembly.build(
            router: router,
            settingsRepository: settingsRepository,
            statisticsManager: statisticsManager
        )
        main.tabBarItem = UITabBarItem(
            title: Constants.firstTabBarItemTitle,
            image: UIImage(systemName: Constants.firstTabBarItemImage),
            selectedImage: UIImage(
                systemName: Constants.firstTabBarItemSelectedImage
            )
        )
        
        let rating = StatisticsScreenAssembly.build(
            settings: settingsRepository,
            statisticsManager: statisticsManager
        )
        rating.tabBarItem = UITabBarItem(
            title: Constants.secondTabBarItemTitle,
            image: UIImage(systemName: Constants.secondTabBarItemImage),
            selectedImage: UIImage(
                systemName: Constants.secondTabBarItemSelectedImage
            )
        )
        
        let controllers: [UIViewController] = [
            main,
            rating
        ]
        return controllers
    }
}
