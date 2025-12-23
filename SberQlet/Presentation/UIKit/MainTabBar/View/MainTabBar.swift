//
//  MainTabBar.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import UIKit

final class MainTabBar: UITabBarController {
    
    private enum Constants {
        static let fatalError = "init(coder:) has not been implemented"
    }
    
    private let viewModel: MainTabBarModel
    
    // MARK: Lifecycle
    
    init(viewModel: MainTabBarModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(viewModel.setupViewControllers(), animated: false)
        
        // Configure appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .clear
    }
}
