//
//  StatisticsScreenBusinessLogic.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

// Бизнес логика экрана
protocol StatisticsScreenBusinessLogic: AnyObject {
    typealias Model = StatisticsScreenModels
    
    // Подготовка к отображению
    func loadStart()
}
