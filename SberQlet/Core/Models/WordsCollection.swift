//
//  WordsCollection.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Модель коллекции слов с переводами
struct WordsCollection: Codable {
    let name: String
    let wordsWithTranslate: [String: String]
    
    // Не декодируется и не кодируется в JSON
    // Только для быстрого доступа от переводов к словам
    private(set) lazy var translateWithWords: [String: String] = {
        var tmp: [String: String] = [:]
        for (word, translate) in wordsWithTranslate {
            tmp[translate] = word
        }
        return tmp
    }()
}
