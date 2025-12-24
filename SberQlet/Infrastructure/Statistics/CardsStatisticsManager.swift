//
//  CardsStatisticsManager.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

final class CardsStatisticsManager: CardsStatisticsManagerLogic {
    
    private var successAmount: Int = 0
    private var failAmount: Int = 0
    
    func getCardsStatistics() -> (success: Int, fail: Int) {
        (
            success: successAmount,
            fail: failAmount
        )
    }
    
    func addToStatistics(successAmount: Int, failAmount: Int) {
        self.successAmount += successAmount
        self.failAmount += failAmount
    }
}
