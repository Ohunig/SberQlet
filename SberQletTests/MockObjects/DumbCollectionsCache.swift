//
//  DumbCollectionsCache.swift
//  SberQletTests
//
//  Created by User on 25.12.2025.
//

import Foundation
@testable import SberQlet

final class DumbCollectionsCache: CollectionsCacheLogic {
    
    var numberOfCollections: Int = 0
    
    var saves: Int = 0
    
    func saveCollections(
        _ collections: [SberQlet.WordsCollection],
        _ url: SberQlet.CacheURL
    ) {
        saves += 1
    }
    
    func loadCollections(
        from url: SberQlet.CacheURL
    ) -> [SberQlet.WordsCollection]? {
        var arr: [WordsCollection] = []
        for i in 0..<numberOfCollections {
            arr.append(
                WordsCollection(
                    name: "\(i)",
                    wordsWithTranslate: [:]
                )
            )
        }
        return arr
    }
}
