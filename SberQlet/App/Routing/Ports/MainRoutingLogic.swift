//
//  MainRoutingLogic.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import Foundation
import UIKit

// Основная логика роутинга
protocol MainRoutingLogic: AnyObject {
    
    // Кладёт новый контроллер на вершину стека
    func pushScreen(viewController: UIViewController)
    
    // Удаляет последний открытый экран со стека
    func popScreen()
    
    // Показывает экран с карточками слов
    func showCardsScreen(
        collection: WordsCollection,
        settings: SettingsRepositoryLogic?
    )
    
    // Показывает экран добавления коллекции
    func showNewCollectionScreen(
        repository: LocalCollectionsRepositoryLogic,
        settings: (any SettingsRepositoryLogic)?
    )
}
