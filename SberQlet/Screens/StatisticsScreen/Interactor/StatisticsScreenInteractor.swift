//
//  StatisticsScreenInteractor.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

final class StatisticsScreenInteractor: StatisticsScreenBusinessLogic {
    
    private let presenter: StatisticsScreenPresentationLogic
    
    private weak var settings: SettingsRepositoryLogic?
    private weak var statisticsManager: CardsStatisticsManagerLogic?
    
    // MARK: Lifecycle
    
    init(
        presenter: StatisticsScreenPresentationLogic,
        settings: SettingsRepositoryLogic?,
        statisticsManager: CardsStatisticsManagerLogic?
    ) {
        self.presenter = presenter
        self.settings = settings
        self.statisticsManager = statisticsManager
    }
    
    // MARK: Use cases
    
    func loadStart() {
        let stats = statisticsManager?.getCardsStatistics()
        if let settings {
            presenter.presentStart(
                Model.Start.Response(
                    palette: [
                        settings.backgroundColor,
                        settings.textColor,
                        settings.elementsColor,
                        settings.labelElementsColor
                    ],
                    knowsNuber: stats?.success ?? 0,
                    doesNotKnowNumber: stats?.fail ?? 0
                )
            )
        } else {
            presenter.presentStart(
                Model.Start.Response(
                    palette: nil,
                    knowsNuber: stats?.success ?? 0,
                    doesNotKnowNumber: stats?.fail ?? 0
                )
            )
        }
    }
}
