//
//  CollectionsCacheService.swift
//  SberQlet
//
//  Created by User on 21.12.2025.
//

import Foundation

// Перечисление, чтобы понимать куда сохраняем
enum CacheURL {
    case local
    case network
}

// Логика кэширования коллекций
protocol CollectionsCacheLogic: AnyObject {
    // Пытается сохранить переданные коллекции в указанное место
    func saveCollections(_ collections: [WordsCollection], _ url: CacheURL)
    
    // Пытается выгрузить данные из указанного места
    func loadCollections(from url: CacheURL) -> [WordsCollection]?
}
