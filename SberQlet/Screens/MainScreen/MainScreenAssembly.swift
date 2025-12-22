//
//  MainScreenAssembly.swift
//  SberQlet
//
//  Created by User on 19.12.2025.
//

import UIKit

enum MainScreenAssembly {
    
    // Сборка экрана
    static func build(
        router: MainRoutingLogic?,
        settingsRepository: SettingsRepositoryLogic?
    ) -> UIViewController {
        let presenter = MainScreenPresenter()
        // Создаём нужные репозитории в билдере главного экрана так как
        // пригодятся только в ветке этого экрана
        let cache = CollectionsCacheService(converter: CollectionsConverter())
        let localRepository = LocalCollectionsRepository(cache: cache)
        let networkRepository = NetworkingCollectionsRepository(
            networkingService: NetworkingService(),
            collectionsConverter: CollectionsConverter(),
            cache: cache
        )
        
        let interactor = MainScreenInteractor(
            router: router,
            presenter: presenter,
            settingsRepository: settingsRepository,
            localRepository: localRepository,
            networkRepository: networkRepository
        )
        
        // Так как интерактор реализует все три протокола
        // Разделил на разные объекты так как контроллеру плевать
        // кто реализует протоколы
        let viewController = MainScreenViewController(
            interactor: interactor,
            localCollectionsStorage: interactor,
            networkCollectionsStorage: interactor,
            componentsFactory: StandardComponentsFactory()
        )
        
        presenter.view = viewController
        return viewController
    }
}
