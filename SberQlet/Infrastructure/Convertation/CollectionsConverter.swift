//
//  CollectionsConverter.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class CollectionsConverter: CollectionsConvertationLogic {
    
    func convertDataToCollections(_ data: Data) -> [WordsCollection]? {
        return try? JSONDecoder().decode([WordsCollection].self, from: data)
    }
    
    func convertCollectionsToData(_ collections: [WordsCollection]) -> Data? {
        return try? JSONEncoder().encode(collections)
    }
}
