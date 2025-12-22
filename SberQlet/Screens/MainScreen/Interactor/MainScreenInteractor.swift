//
//  MainScreenInteractor.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class MainScreenInteractor: MainScreenBusinessLogic {
    
    private enum Constants {
        static let collectionsUrlString = "https://gitverse.ru/api/repos/Ohunig/JsonCards/raw/branch/master/PopularCards.json"
    }
    
    private weak var router: MainRoutingLogic?
    
    private let presenter: MainScreenPresentationLogic
    
    private weak var settingsRepository: SettingsRepositoryLogic?
    
    private let networkRepository: NetworkingCollectionsRepositoryLogic
    
    private let localRepository: LocalCollectionsRepositoryLogic
    
    // MARK: Lifecycle
    
    init(
        router: MainRoutingLogic?,
        presenter: MainScreenPresentationLogic,
        settingsRepository: SettingsRepositoryLogic?,
        localRepository: LocalCollectionsRepositoryLogic,
        networkRepository: NetworkingCollectionsRepositoryLogic
    ) {
        self.router = router
        self.presenter = presenter
        self.settingsRepository = settingsRepository
        self.localRepository = localRepository
        self.networkRepository = networkRepository
    }
    
    // MARK: Use-cases
    
    func loadStart() {
        guard let settingsRepository else {
            return
        }
        presenter.presentStart(
            Model.Start.Response(
                palette: [
                    settingsRepository.backgroundColor,
                    settingsRepository.textColor,
                    settingsRepository.elementsColor,
                    settingsRepository.labelElementsColor
                ]
            )
        )
    }
    
    func fetchData() {
        // TODO: Completion
        localRepository.fetchDataFromLocalStorage()
        networkRepository.fetchCollections(from: Constants.collectionsUrlString) { result in
            DispatchQueue.main.async {
                self.presenter.presentFetchedData()
            }
        }
    }
}

// MARK: - Local collections access

extension MainScreenInteractor: LocalCollectionsDataAccess {
    
    var localCollectionsCount: Int {
        localRepository.count
    }
    
    func getLocalCollectionInfo(index: Int) -> (name: String, wordsCount: Int)? {
        guard let collection = localRepository.getCollection(withIndex: index)
        else {
            return nil
        }
        return (collection.name, collection.wordsWithTranslate.count)
    }
}

// MARK: - Network collections access

extension MainScreenInteractor: NetworkCollectionsDataAccess {
    
    var networkCollectionsCount: Int {
        networkRepository.count
    }
    
    func getNetworkCollectionInfo(index: Int) -> (name: String, wordsCount: Int)? {
        guard let collection = networkRepository.getCollection(withIndex: index)
        else {
            return nil
        }
        return (collection.name, collection.wordsWithTranslate.count)
    }
}
