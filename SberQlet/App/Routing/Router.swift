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
    
    weak var newWordResultDelegate: NewWordResultDelegate?
    
    init(controller: UINavigationController) {
        navigationController = controller
    }
    
    func pushScreen(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func showCardsScreen(
        collection: WordsCollection,
        settings: SettingsRepositoryLogic?,
        statisticsManager: CardsStatisticsManagerLogic?
    ) {
        pushScreen(
            viewController: CardsScreenAssembly.build(
                collection: collection,
                router: self,
                settings: settings,
                statisticsManager: statisticsManager
            )
        )
    }
    
    func showNewCollectionScreen(
        repository: LocalCollectionsRepositoryLogic,
        settings: SettingsRepositoryLogic?
    ) {
        pushScreen(
            viewController: NewCollectionScreenAssembly.build(
                repository: repository,
                router: self,
                settings: settings
            )
        )
    }
    
    func showNewWordScreen(
        settings: SettingsRepositoryLogic?
    ) {
        pushScreen(
            viewController: NewWordScreenAssembly.build(
                router: self,
                settings: settings
            )
        )
    }
    
    func showNewCollectionFromNewWordScreen(
        response: RoutingDataModel.NewWordAndNewCollectionScreen.Response
    ) {
        popScreen()
        newWordResultDelegate?.newWordResult(response)
    }
}
