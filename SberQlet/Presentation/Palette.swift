//
//  Palette.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import Foundation
import SwiftUI

// Модель палитры цветов
struct Palette {
    let backgroundUIColor: UIColor
    let textUIColor: UIColor
    let elementsUIColor: UIColor
    let labelElementsUIColor: UIColor
    
    var backgroundColor: Color {
        Color(backgroundUIColor)
    }
    
    var textColor: Color {
        Color(textUIColor)
    }
    
    var elementsColor: Color {
        Color(elementsUIColor)
    }
    
    var labelElementsColor: Color {
        Color(labelElementsUIColor)
    }
    
    // MARK: Inits
    
    init() {
        self.backgroundUIColor = .clear
        self.textUIColor = .clear
        self.elementsUIColor = .clear
        self.labelElementsUIColor = .clear
    }
    
    init(
        backgroundColor: (ColorModel, ColorModel),
        textColor: (ColorModel, ColorModel),
        elementsColor: (ColorModel, ColorModel),
        labelElementsColor: (ColorModel, ColorModel)
    ) {
        self.backgroundUIColor = UIColor(backgroundColor)
        self.textUIColor = UIColor(textColor)
        self.elementsUIColor = UIColor(elementsColor)
        self.labelElementsUIColor = UIColor(labelElementsColor)
    }
}
