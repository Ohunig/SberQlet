//
//  NewCollectionScreenAssembly.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import SwiftUI

enum NewCollectionScreenAssembly {
    
    static func build(
        repository: LocalCollectionsRepositoryLogic,
        router: MainRoutingLogic?,
        settings: SettingsRepositoryLogic?
    ) -> UIViewController {
        let viewModel = NewCollectionViewModel(
            repository: repository,
            router: router,
            settings: settings
        )
        let view = NewCollectionContentView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}
