//
//  CollectionsRepositoryLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Ошибка работы с локальным репозиторием
enum LocalCollectionsRepositoryError: Error {
    // Название коллекции дублируется
    case duplicateCollectionName
}

// Расширение добавляющее описание ошибки
extension LocalCollectionsRepositoryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .duplicateCollectionName:
            return "Такое название уже используется"
        }
    }
}

// Логика репозитория для локальных коллекций слов
protocol LocalCollectionsRepositoryLogic: AnyObject {
    
    // Количество хранимых коллекций
    var count: Int { get }
    
    // Возвращает коллекцию под нужным индексом если индекс корректен
    func getCollection(withIndex index: Int) -> WordsCollection?
    
    // Добавляет новую коллекцию или кидает ошибку (Названия должны быть уникальны)
    func addCollection(_ collection: WordsCollection) throws
    
    // Удаляет коллекцию под нужным индексом если индекс корректен
    func deleteCollection(withIndex index: Int)
    
    // Подтягивает данные из локального хранилища
    func fetchDataFromLocalStorage()
}
