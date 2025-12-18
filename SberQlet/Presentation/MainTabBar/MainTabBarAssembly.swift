//
//  MainTabBarAssembly.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import Foundation
import UIKit

enum MainTabBarAssembly {
    
    static func build(router: MainRoutingLogic) -> UIViewController {
        let viewModel = MainTabBarModel(router: router)
        let viewController = MainTabBar(viewModel: viewModel)
        
        return viewController
    }
}
