//
//  DumbCollectionsConverter .swift
//  SberQletTests
//
//  Created by User on 25.12.2025.
//

import Foundation
@testable import SberQlet

final class DumbCollectionsConverter: CollectionsConvertationLogic {
    
    let numberOfCollections: Int
    
    init() {
        numberOfCollections = 0
    }
    
    init(numberOfCollections: Int) {
        self.numberOfCollections = numberOfCollections
    }
    
    func convertDataToCollections(_ data: Data) -> [WordsCollection]? {
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
    
    func convertCollectionsToData(_ collections: [WordsCollection]) -> Data? {
        return nil
    }
}
