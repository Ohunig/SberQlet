//
//  Router.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import Foundation
import UIKit

final class Router: MainRoutingLogic {
    
    private weak var navigationController: UINavigationController?
    
    init(controller: UINavigationController) {
        navigationController = controller
    }
    
    func pushScreen(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func showCardsScreen(collection: WordsCollection, settings: (any SettingsRepositoryLogic)?) {
        pushScreen(
            viewController: CardsScreenAssembly.build(
                router: self,
                collection: collection,
                settings: settings
            )
        )
    }
}
