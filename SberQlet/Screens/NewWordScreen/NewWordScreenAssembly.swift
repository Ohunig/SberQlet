//
//  NewWordScreenAssembly.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import SwiftUI

enum NewWordScreenAssembly {
    
    static func build(
        router: MainRoutingLogic?,
        settings: SettingsRepositoryLogic?
    ) -> UIViewController {
        let viewModel = NewWordViewModel(
            router: router,
            settings: settings
        )
        let view = NewWordContentView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}
