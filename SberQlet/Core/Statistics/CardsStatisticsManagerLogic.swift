//
//  StatisticsManagerLogic.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

// Логика менеджера по подсчёту статистики
protocol CardsStatisticsManagerLogic: AnyObject {
    
    // Выдать статистику
    func getCardsStatistics() -> (
        success: Int,
        fail: Int
    )
    
    // Добавить значения в статистику
    func addToStatistics(
        successAmount: Int,
        failAmount: Int
    )
}
