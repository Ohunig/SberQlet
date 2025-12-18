//
//  MainTabViewModel.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import UIKit

final class MainTabBarModel {
    
    private weak var router: MainRoutingLogic?
    
    init(router: MainRoutingLogic) {
        self.router = router
    }
    
    func setupViewControllers() -> [UIViewController] {
        let main = MainScreenViewController()
        main.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let rating = MainScreenViewController()
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
