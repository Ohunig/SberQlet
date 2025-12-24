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
    
    // Делегат для передачи результата экрана нового слова
    var newWordResultDelegate: NewWordResultDelegate? { get set }
    
    // Кладёт новый контроллер на вершину стека
    func pushScreen(viewController: UIViewController)
    
    // Удаляет последний открытый экран со стека
    func popScreen()
    
    // Показывает экран с карточками слов
    func showCardsScreen(
        collection: WordsCollection,
        settings: SettingsRepositoryLogic?,
        statisticsManager: CardsStatisticsManagerLogic?
    )
    
    // Показывает экран добавления коллекции
    func showNewCollectionScreen(
        repository: LocalCollectionsRepositoryLogic,
        settings: SettingsRepositoryLogic?
    )
    
    // Показывает экран добавления слова
    func showNewWordScreen(
        settings: SettingsRepositoryLogic?
    )
    
    // Возвращается на экран новой коллекции из экрана нового слова
    func showNewCollectionFromNewWordScreen(
        response: RoutingDataModel.NewWordAndNewCollectionScreen.Response
    )
}
