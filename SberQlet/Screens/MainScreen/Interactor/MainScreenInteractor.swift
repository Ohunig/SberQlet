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
    
    private weak var settingsRepository: SettingsRepositoryLogic?
    
    private weak var statisticsManager: CardsStatisticsManagerLogic?
    
    private let presenter: MainScreenPresentationLogic
    
    private let networkRepository: NetworkingCollectionsRepositoryLogic
    
    private let localRepository: LocalCollectionsRepositoryLogic
    
    // MARK: Lifecycle
    
    init(
        presenter: MainScreenPresentationLogic,
        localRepository: LocalCollectionsRepositoryLogic,
        networkRepository: NetworkingCollectionsRepositoryLogic,
        router: MainRoutingLogic?,
        settingsRepository: SettingsRepositoryLogic?,
        statisticsManager: CardsStatisticsManagerLogic?
    ) {
        self.router = router
        self.presenter = presenter
        self.settingsRepository = settingsRepository
        self.localRepository = localRepository
        self.networkRepository = networkRepository
        self.statisticsManager = statisticsManager
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
        localRepository.fetchDataFromLocalStorage()
        networkRepository.fetchCollections(from: Constants.collectionsUrlString) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.presenter.presentFetchedData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presenter.presentError(
                        Model.ErrorModels.Response(
                            error: error
                        )
                    )
                }
            }
        }
    }
    
    func goToCardsScreen(_ request: Model.GoToCardsScreen.Request) {
        var collection: WordsCollection?
        if request.fromLocal {
            collection = localRepository.getCollection(
                withIndex: request.index
            )
        } else {
            collection = networkRepository.getCollection(
                withIndex: request.index
            )
        }
        guard let collection else {
            return
        }
        router?.showCardsScreen(
            collection: collection,
            settings: settingsRepository,
            statisticsManager: statisticsManager
        )
    }
    
    func goToNewCollectionScreen() {
        router?.showNewCollectionScreen(
            repository: localRepository,
            settings: settingsRepository
        )
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
