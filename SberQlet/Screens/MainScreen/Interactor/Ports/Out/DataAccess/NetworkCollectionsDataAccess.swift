//
//  NetworkCollectionsDataAccess.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Протокол для доступа к данным коллекций слов подтянутых из сети
protocol NetworkCollectionsDataAccess: AnyObject {
    // Количество коллекций
    var networkCollectionsCount: Int { get }
    
    // Выдаёт информацию о коллекции если индекс корректен
    func getNetworkCollectionInfo(index: Int) -> (name: String, wordsCount: Int)?
}
