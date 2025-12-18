//
//  LocalCollectionsDataAccess.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Протокол для доступа к данным локальных коллекций слов
protocol LocalCollectionsDataAccess: AnyObject {
    
    // Количество коллекций
    var localCollectionsCount: Int { get }
    
    // Выдаёт информацию о коллекции если индекс корректен
    func getLocalCollectionInfo(index: Int) -> (name: String, wordsCount: Int)?
}
