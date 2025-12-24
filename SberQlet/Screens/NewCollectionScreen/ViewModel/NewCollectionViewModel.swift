//
//  NewCollectionViewModel.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation
import Combine

final class NewCollectionViewModel: ObservableObject {
    
    @Published var name: String = ""
    
    @Published var words: [String: String] = ["Aboba": "Абоба"]
    
    @Published var showError: Bool = false
    var errorText: String = ""
    
    private weak var router: MainRoutingLogic?
    private let repository: LocalCollectionsRepositoryLogic
    let palette: Palette
    
    // MARK: Lifecycle
    
    init(
        repository: LocalCollectionsRepositoryLogic,
        router: MainRoutingLogic?,
        settings: SettingsRepositoryLogic?
    ) {
        self.router = router
        self.repository = repository
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
    
    func addCollection() {
        do {
            try repository.addCollection(
                WordsCollection(
                    name: name,
                    wordsWithTranslate: words
                )
            )
            // Экран выполнил свою работу
            router?.popScreen()
        } catch {
            showError = true
            errorText = "Коллекция с таким названием уже существует"
        }
    }
}
