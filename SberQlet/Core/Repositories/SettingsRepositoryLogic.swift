//
//  SettingsRepositoryLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Логика репозитория настроек
// Цветовая палитра приложения
protocol SettingsRepositoryLogic: AnyObject {
    
    // Цвета фона (светлая и тёмная тема)
    var backgroundColor: (ColorModel, ColorModel) { get }
    
    // Цвета текста (светлая и тёмная тема)
    var textColor: (ColorModel, ColorModel) { get }
    
    // Цвета элементов (светлая и тёмная тема)
    var elementsColor: (ColorModel, ColorModel) { get }
    
    // Цвета элементов с текстом (светлая и тёмная тема)
    var labelElementsColor: (ColorModel, ColorModel) { get }
}
