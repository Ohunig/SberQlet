//
//  NetworkingCollectionsRepository.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class NetworkingCollectionsRepository: NetworkingCollectionsRepositoryLogic {
    
    private let networking: NetworkingLogic
    
    private let collectionsConverter: CollectionsConvertationLogic
    
    private let cache: CollectionsCacheLogic
    
    private var storage: [WordsCollection] = []
    
    var isUpToDate: Bool {
        count != 0
    }
    
    var count: Int {
        storage.count
    }
    
    // MARK: Lifecycle
    
    init(
        networkingService: NetworkingLogic,
        collectionsConverter: CollectionsConvertationLogic,
        cache: CollectionsCacheLogic
    ) {
        networking = networkingService
        self.collectionsConverter = collectionsConverter
        self.cache = cache
    }
    
    // MARK: Use-cases
    
    func getCollection(withIndex index: Int) -> WordsCollection? {
        guard index >= 0 && index < storage.count else {
            return nil
        }
        return storage[index]
    }
    
    
    func fetchCollections(
        from url: String,
        completion: @escaping @Sendable (Result<Void, any Error>) -> Void
    ) {
        let collections = cache.loadCollections(from: .network)
        if collections == nil || collections == [] {
            guard let correctUrl = URL(string: url) else {
                completion(.failure(URLError(.badURL)))
                return
            }
            networking.fetchData(from: correctUrl) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        guard let collections = self?.collectionsConverter.convertDataToCollections(data)
                        else {
                            completion(
                                .failure(
                                    CollectionsConvertationError.convertationFailed
                                )
                            )
                            return
                        }
                        self?.storage = collections
                        self?.cache.saveCollections(
                            self?.storage ?? [],
                            .network
                        )
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        else {
            self.storage = collections ?? []
            completion(.success(()))
        }
    }
}
