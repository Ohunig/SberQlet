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
        router: MainRoutingLogic?,
        collection: WordsCollection,
        settings: SettingsRepositoryLogic?
    ) -> UIViewController {
        let viewModel = CardsScreenViewModel(
            router: router,
            collection: collection,
            settings: settings
        )
        let view = CardScreenContentView(
            viewModel: viewModel
        )
        return UIHostingController(rootView: view)
    }
}
