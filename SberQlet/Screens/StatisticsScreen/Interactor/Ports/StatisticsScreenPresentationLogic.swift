//
//  StatisticsScreenPresentationLogic.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

// Логика презентации экрана
protocol StatisticsScreenPresentationLogic: AnyObject {
    typealias Model = StatisticsScreenModels
    
    // Презентует начало
    func presentStart(_ response: Model.Start.Response)
}
