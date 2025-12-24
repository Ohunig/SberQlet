//
//  NewCollectionViewModel.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation
import Combine

final class NewCollectionViewModel: ObservableObject {
    
    private enum Constants {
        static let sameNameError = "Коллекция с таким названием уже существует"
    }
    
    @Published var name: String = ""
    
    @Published var words: [String: String] = [:]
    
    @Published var showError: Bool = false
    var errorText: String = ""
    
    private weak var router: MainRoutingLogic?
    private let repository: LocalCollectionsRepositoryLogic
    private let settings: SettingsRepositoryLogic?
    let palette: Palette
    
    // MARK: Lifecycle
    
    init(
        repository: LocalCollectionsRepositoryLogic,
        router: MainRoutingLogic?,
        settings: SettingsRepositoryLogic?
    ) {
        self.router = router
        self.repository = repository
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
        router?.newWordResultDelegate = self
    }
    
    // MARK: Use cases
    
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
            errorText = Constants.sameNameError
        }
    }
    
    func addWord() {
        router?.showNewWordScreen(settings: settings)
    }
}

// MARK: - New word result delegate

extension NewCollectionViewModel: NewWordResultDelegate {
    
    func newWordResult(
        _ response: RoutingDataModel.NewWordAndNewCollectionScreen.Response
    ) {
        words[response.word] = response.translation
    }
}
