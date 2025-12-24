//
//  NewWordScreenResultDelegate.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

// Делегат для передачи данных о результате работы экрана добавления слова
protocol NewWordResultDelegate: AnyObject {
    // Результат выполнения экрана добавления слова
    func newWordResult(
        _ response: RoutingDataModel.NewWordAndNewCollectionScreen.Response
    )
}
