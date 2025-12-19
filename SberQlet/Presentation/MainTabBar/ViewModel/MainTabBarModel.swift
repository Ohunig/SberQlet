//
//  MainTabViewModel.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import UIKit

final class MainTabBarModel {
    
    private let router: MainRoutingLogic
    
    private let settingsRepository: SettingsRepositoryLogic
    
    init(
        router: MainRoutingLogic,
        settingsRepository: SettingsRepositoryLogic
    ) {
        self.router = router
        self.settingsRepository = settingsRepository
    }
    
    func setupViewControllers() -> [UIViewController] {
        let main = MainScreenAssembly.build(
            router: router,
            settingsRepository: settingsRepository
        )
        main.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let rating = MainScreenAssembly.build(
            router: router,
            settingsRepository: settingsRepository
        )
        rating.tabBarItem = UITabBarItem(
            title: "Rating",
            image: UIImage(systemName: "chart.line.text.clipboard"),
            selectedImage: UIImage(systemName: "chart.line.text.clipboard.fill")
        )
        
        let controllers: [UIViewController] = [
            main,
            rating
        ]
        return controllers
    }
}
