//
//  RoutingDataModel.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

// Модели для передачи данных между экранами
// Пока что используется только для передачи данных при выходе из экрана
struct RoutingDataModel {
    enum NewWordAndNewCollectionScreen {
        struct Response {
            let word: String
            let translation: String
        }
    }
}
