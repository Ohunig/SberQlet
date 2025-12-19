//
//  MainScreenPresentationLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Логика презентации главного экрана
// Находится в модуле Interactor для инверсии зависимостей
protocol MainScreenPresentationLogic: AnyObject {
    typealias Model = MainScreenModels
    
    // Презентация начальных настроек экрана
    func presentStart(_ response: Model.Start.Response)
}
