//
//  SberQletTests.swift
//  SberQletTests
//
//  Created by User on 25.12.2025.
//

import Testing
import Foundation
@testable import SberQlet

@MainActor
struct NetworkingCollectionsRepositoryTests {

    @Test(arguments: [1, 5, 100])
    func whenSizeIsNotNullThenIsUpToDate(numberCollections: Int) async {
        // arrange
        let cache = DumbCollectionsCache()
        let converter = DumbCollectionsConverter(numberOfCollections: numberCollections)
        cache.numberOfCollections = numberCollections
        let repo = NetworkingCollectionsRepository(
            networkingService: DumbNetworkingService(),
            collectionsConverter: converter,
            cache: cache
        )
        
        // act
        await withCheckedContinuation { continuation in
            repo.fetchCollections(from: "test") {_ in continuation.resume()}
        }
        
        // assert
        #expect(repo.isUpToDate)
    }
    
    @Test
    func whenSizeIsNullThenNotIsUpToDate() async {
        // arrange
        let repo = NetworkingCollectionsRepository(
            networkingService: DumbNetworkingService(),
            collectionsConverter: DumbCollectionsConverter(),
            cache: DumbCollectionsCache()
        )
        
        // act
        await withCheckedContinuation { continuation in
            repo.fetchCollections(from: "test") {_ in continuation.resume()}
        }
        
        // assert
        #expect(!repo.isUpToDate)
    }
    
    @Test(arguments: [1, 5, 100])
    func whenFetchDataThenCorrectNumberOfCollections(
        numberCollections: Int
    ) async {
        // arrange
        let cache = DumbCollectionsCache()
        let converter = DumbCollectionsConverter(numberOfCollections: numberCollections)
        cache.numberOfCollections = numberCollections
        let repo = NetworkingCollectionsRepository(
            networkingService: DumbNetworkingService(),
            collectionsConverter: converter,
            cache: cache
        )
        
        // act
        await withCheckedContinuation { continuation in
            repo.fetchCollections(from: "test") {_ in continuation.resume()}
        }
        
        // assert
        #expect(repo.count == numberCollections)
    }
    
    @Test(arguments: [0, 2, 4])
    func whenGetCollectionByCorrectIndexThenCorrectCollection(
        index: Int
    ) async {
        // arrange
        let cache = DumbCollectionsCache()
        let converter = DumbCollectionsConverter(numberOfCollections: 5)
        cache.numberOfCollections = 5
        let repo = NetworkingCollectionsRepository(
            networkingService: DumbNetworkingService(),
            collectionsConverter: converter,
            cache: cache
        )
        
        // act
        await withCheckedContinuation { continuation in
            repo.fetchCollections(from: "Test", completion: {_ in continuation.resume()})
        }
        let collection = repo.getCollection(withIndex: index)
        
        // assert
        #expect(collection != nil)
        guard let collection else {
            return
        }
        #expect(collection.name == "\(index)")
    }
    
    @Test(arguments: [-1, 5, 100])
    func whenGetCollectionByIncorrectIndexThenNil(
        index: Int
    ) async {
        // arrange
        let cache = DumbCollectionsCache()
        let converter = DumbCollectionsConverter(numberOfCollections: 5)
        cache.numberOfCollections = 5
        let repo = NetworkingCollectionsRepository(
            networkingService: DumbNetworkingService(),
            collectionsConverter: converter,
            cache: cache
        )
        
        // act
        await withCheckedContinuation { continuation in
            repo.fetchCollections(from: "Test", completion: {_ in continuation.resume()})
        }
        let collection = repo.getCollection(withIndex: index)
        
        // assert
        #expect(collection == nil)
    }
    
    @Test
    func whenFetchingCollectionsThenCacheIsUpdated() async {
        // arrange
        let cache = DumbCollectionsCache()
        let converter = DumbCollectionsConverter(numberOfCollections: 5)
        cache.numberOfCollections = 0
        let repo = NetworkingCollectionsRepository(
            networkingService: DumbNetworkingService(),
            collectionsConverter: converter,
            cache: cache
        )
        
        // act
        await withCheckedContinuation { continuation in
            repo.fetchCollections(from: "Test", completion: {_ in continuation.resume()})
        }
        
        // assert
        #expect(cache.saves == 1)
    }
}
