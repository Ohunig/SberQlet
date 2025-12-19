//
//  SettingsRepository.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class SettingsRepository: SettingsRepositoryLogic {
    
    private enum Constants {
        // Стандартные цвета
        // Фон
        static let lightBackgroundColor = ColorModel(
            red: Int(255),
            green: 190,
            blue: 64
        )
        static let darkBackgroundColor = ColorModel(
            red: Int(18),
            green: 64,
            blue: 171
        )
        // Текст
        static let lightTextColor = ColorModel(
            red: Int(166),
            green: 110,
            blue: 0
        )
        static let darkTextColor = ColorModel(
//            red: Int(108),
//            green: 140,
//            blue: 213
            red: Int(140),
            green: 180,
            blue: 243
        )
        
        // Элементы интерфейса
        static let lightElementsColor = ColorModel(
            red: Int(255),
            green: 169,
            blue: 0
        )
        static let darkElementsColor = ColorModel(
            red: Int(6),
            green: 38,
            blue: 111
        )
        
        // Текстовые поля
        static let lightLabelElementsColor = ColorModel(
            red: Int(255),
            green: 207,
            blue: 115
        )
        static let darkLabelElementsColor = ColorModel(
            red: Int(70),
            green: 113,
            blue: 213
        )
    }
    
    var backgroundColor: (ColorModel, ColorModel) {
        return (
            Constants.lightBackgroundColor,
            Constants.darkBackgroundColor
        )
    }
    
    var textColor: (ColorModel, ColorModel) {
        return (
            Constants.lightTextColor,
            Constants.darkTextColor
        )
    }
    
    var elementsColor: (ColorModel, ColorModel) {
        return (
            Constants.lightElementsColor,
            Constants.darkElementsColor
        )
    }
    
    var labelElementsColor: (ColorModel, ColorModel) {
        return (
            Constants.lightLabelElementsColor,
            Constants.darkLabelElementsColor
        )
    }
}
