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
}
