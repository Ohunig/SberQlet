//
//  NetworkingCollectionsRepositoryLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Логика репозитория работающего с сетью
protocol NetworkingCollectionsRepositoryLogic: AnyObject {
    // Были ли загружены данные
    var isUpToDate: Bool { get }
    
    // Количество хранимых слов
    var count: Int { get }
    
    // Возвращает коллекцию под нужным индексом если индекс корректен
    func getCollection(withIndex index: Int) -> WordsCollection?
    
    // Подтягивает данные о коллекциях из сети
    func fetchCollections(
        from url: String,
        completion : @escaping @Sendable (Result<Void, Error>) -> Void
    )
}
