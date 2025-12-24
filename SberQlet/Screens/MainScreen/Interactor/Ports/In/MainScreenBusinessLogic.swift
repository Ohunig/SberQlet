//
//  MainScreenBusinessLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Бизнес-логика главного экрана
protocol MainScreenBusinessLogic: AnyObject {
    typealias Model = MainScreenModels
    
    // Загрузка начальных настроек экрана
    func loadStart()
    
    // Загрузка данных из сети и локальных данных
    func fetchData()
    
    // Переход на экран с картами
    // Если fromLocal == true => коллекция из локальных
    // Если нет, то из полученных из сети
    func goToCardsScreen(_ request: Model.GoToCardsScreen.Request)
    
    // Переход на экран добавления новой коллекции
    func goToNewCollectionScreen()
}
