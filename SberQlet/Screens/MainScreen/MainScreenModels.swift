//
//  MainScreenModels.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Модели передачи данных Main screen
struct MainScreenModels {
    
    // Модели для передачи данных при старте экрана
    enum Start {
        struct Response {
            let palette: [(ColorModel, ColorModel)]
        }
        struct ViewModel {
            let palette: (
                backgroundColor: (ColorModel, ColorModel),
                textColor: (ColorModel, ColorModel),
                elementsColor: (ColorModel, ColorModel),
                labelElementsColor: (ColorModel, ColorModel)
            )
        }
    }
    
    // Модели для передачи данных об ошибке
    enum ErrorModels {
        struct Response {
            let error: Error
        }
        struct ViewModel {
            let errorString: String
        }
    }
    
    // Модели для перехода на экран с карточками
    enum GoToCardsScreen {
        struct Request {
            let index: Int
            let fromLocal: Bool
        }
    }
}
