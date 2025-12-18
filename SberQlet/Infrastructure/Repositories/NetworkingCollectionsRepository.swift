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
        collectionsConverter: CollectionsConvertationLogic
    ) {
        networking = networkingService
        self.collectionsConverter = collectionsConverter
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
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
