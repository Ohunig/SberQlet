//
//  StatisticsScreenAssembly.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import UIKit

enum StatisticsScreenAssembly {
    
    static func build(
        settings: SettingsRepositoryLogic?,
        statisticsManager: CardsStatisticsManagerLogic?
    ) -> UIViewController {
        let presenter = StatisticsScreenPresenter()
        
        let interactor = StatisticsScreenInteractor(
            presenter: presenter,
            settings: settings,
            statisticsManager: statisticsManager
        )
        
        let view = StatisticsViewController(
            interactor: interactor,
            componentsFactory: StandardComponentsFactory()
        )
        
        presenter.view = view
        return view
    }
}
