//
//  StatisticsScreenDisplayLogic.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

// Логика отображения
protocol StatisticsScreenDisplayLogic: AnyObject {
    typealias Model = StatisticsScreenModels
    
    // Отобразить старт
    func displayStart(_ viewModel: Model.Start.ViewModel)
}
