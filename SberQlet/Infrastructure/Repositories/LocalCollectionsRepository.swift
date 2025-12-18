//
//  LocalCollectionsRepository.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class LocalCollectionsRepository: LocalCollectionsRepositoryLogic {
    
    private var storage: [WordsCollection] = []
    
    var count: Int {
        storage.count
    }
    
    func getCollection(withIndex index: Int) -> WordsCollection? {
        guard index >= 0 && index < storage.count else {
            return nil
        }
        return storage[index]
    }
    
    func addCollection(_ collection: WordsCollection) throws {
        for i in storage {
            if i.name == collection.name {
                throw LocalCollectionsRepositoryError.duplicateCollectionName
            }
        }
        storage.append(collection)
    }
    
    func deleteCollection(withIndex index: Int) {
        guard index >= 0 && index < storage.count else {
            return
        }
        storage.remove(at: index)
    }
}
