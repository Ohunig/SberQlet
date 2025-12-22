//
//  CollectionsCacheService.swift
//  SberQlet
//
//  Created by User on 21.12.2025.
//

import Foundation

final class CollectionsCacheService: CollectionsCacheLogic {
    
    private enum Constants {
        static let localCollectionsCacheFileName = "localCollections.json"
        static let networkCollectionsCacheFileName = "networkCollections.json"
    }
    
    private let converter: CollectionsConvertationLogic
    
    private var cacheDirectory: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    init(converter: CollectionsConvertationLogic) {
        self.converter = converter
    }
    
    private func localCacheURL() -> URL {
        cacheDirectory
            .appendingPathComponent(Constants.localCollectionsCacheFileName)
    }
    
    private func networkCacheURL() -> URL {
        cacheDirectory
            .appendingPathComponent(Constants.networkCollectionsCacheFileName)
    }
    
    // MARK: Use-cases
    
    func saveCollections(_ collections: [WordsCollection], _ url: CacheURL) {
        var finalURL: URL
        switch url {
        case .local:
            finalURL = localCacheURL()
        case .network:
            finalURL = networkCacheURL()
        }
        let data = converter.convertCollectionsToData(collections)
        try? data?.write(to: finalURL, options: [.atomicWrite])
    }
    
    func loadCollections(from url: CacheURL) -> [WordsCollection]? {
        var finalURL: URL
        switch url {
        case .local:
            finalURL = localCacheURL()
        case .network:
            finalURL = networkCacheURL()
        }
        let data = try? Data(contentsOf: finalURL)
        let collections = converter.convertDataToCollections(data ?? Data())
        return collections
    }
}
