//
//  NewWordViewModel.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation
import Combine

final class NewWordViewModel: ObservableObject {
    
    @Published var word: String = ""
    @Published var translation: String = ""
    
    private weak var router: MainRoutingLogic?
    private let settings: SettingsRepositoryLogic?
    let palette: Palette
    
    init(
        router: MainRoutingLogic?,
        settings: SettingsRepositoryLogic?
    ) {
        self.router = router
        self.settings = settings
        if let settings {
            self.palette = Palette(
                backgroundColor: settings.backgroundColor,
                textColor: settings.textColor,
                elementsColor: settings.elementsColor,
                labelElementsColor: settings.labelElementsColor
            )
        } else {
            self.palette = Palette()
        }
    }
    
    func addWord() {
        router?.showNewCollectionFromNewWordScreen(
            response: RoutingDataModel.NewWordAndNewCollectionScreen
                .Response(
                    word: word,
                    translation: translation
                )
        )
    }
}
