//
//  Flashcard.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import Foundation

// Модель карточки со словом
struct Flashcard: Identifiable {
    // Чтобы отличать карточки между собой
    let id = UUID()
    // Переднее слово
    let front: String
    // Заднее слово
    let back: String
}
