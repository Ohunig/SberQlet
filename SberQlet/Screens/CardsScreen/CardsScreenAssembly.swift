//
//  CardsScreenAssembly.swift
//  SberQlet
//
//  Created by User on 23.12.2025.
//

import Foundation
import SwiftUI

enum CardsScreenAssembly {
    
    static func build(
        collection: WordsCollection,
        router: MainRoutingLogic?,
        settings: SettingsRepositoryLogic?,
        statisticsManager: CardsStatisticsManagerLogic?
    ) -> UIViewController {
        let viewModel = CardsScreenViewModel(
            collection: collection,
            router: router,
            settings: settings,
            statisticsManager: statisticsManager
        )
        let view = CardScreenContentView(
            viewModel: viewModel
        )
        return UIHostingController(rootView: view)
    }
}
