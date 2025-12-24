//
//  StatisticsScreenModels.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

// Модели для передачи данных экрана статистики
struct StatisticsScreenModels {
    // Модели для старта
    enum Start {
        struct Response {
            let palette: [(ColorModel, ColorModel)]?
            let knowsNuber: Int
            let doesNotKnowNumber: Int
        }
        
        struct ViewModel {
            let palette: (
                backgroundColor: (ColorModel, ColorModel)?,
                textColor: (ColorModel, ColorModel)?,
                elementsColor: (ColorModel, ColorModel)?,
                labelElementsColor: (ColorModel, ColorModel)?
            )
            let knowsNuber: Int
            let doesNotKnowNumber: Int
        }
    }
}
