//
//  DisplayLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Логика отображения
// В presenter для инверсии зависимостей
protocol MainScreenDisplayLogic: AnyObject {
    typealias Model = MainScreenModels

    // Отобразить начальное состояние экрана
    func displayStart(_ viewModel: Model.Start.ViewModel)
}
