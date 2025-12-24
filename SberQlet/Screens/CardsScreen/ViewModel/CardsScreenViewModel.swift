//
//  CardsScreenViewModel.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import Foundation
import Combine

// Для данного экрана использую архитектурный паттерн MVVM так как
// используется SwiftUI -> удобнее (как минимум мне)
final class CardsScreenViewModel: ObservableObject {
    
    let palette: Palette
    let cards: [Flashcard]
    
    @Published var currentIndex: Int = 0
    
    @Published var rightCount: Int = 0
    @Published var leftCount: Int = 0
    
    private weak var router: MainRoutingLogic?
    private weak var statisticsManager: CardsStatisticsManagerLogic?
    
    init(
        collection: WordsCollection,
        router: MainRoutingLogic?,
        settings: SettingsRepositoryLogic?,
        statisticsManager: CardsStatisticsManagerLogic?
    ) {
        self.router = router
        self.statisticsManager = statisticsManager
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
        var copyCards: [Flashcard] = []
        for i in collection.wordsWithTranslate.indices {
            let key = collection.wordsWithTranslate.keys[i]
            copyCards.append(
                Flashcard(
                    front: key,
                    back: collection.wordsWithTranslate[key] ?? ""
                )
            )
        }
        cards = copyCards
    }
    
    func addToStatistics() {
        statisticsManager?.addToStatistics(
            successAmount: rightCount,
            failAmount: leftCount
        )
    }
}
