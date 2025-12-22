//
//  DataToCollectionsConvertationLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Ошибка конвертации
enum CollectionsConvertationError: Error {
    case convertationFailed
}

// Расширение добавляющее описание ошибки
extension CollectionsConvertationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .convertationFailed:
            "Convertation failed: data is not correct"
        }
    }
}

// Логика конвертирования для коллекций слов
protocol CollectionsConvertationLogic: AnyObject, Sendable {
    
    // Конвертирует данные в список коллекций. Возвращает nil в случае неудачи
    func convertDataToCollections(_ data: Data) -> [WordsCollection]?
    
    // Конвертирует список коллекций в данные
    func convertCollectionsToData(_ collections: [WordsCollection]) -> Data?
}
