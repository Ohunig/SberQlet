//
//  ColorModel.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Модель цвета, чтобы не связывать бизнес-логику с UI
struct ColorModel {
    
    private enum Constants {
        static let maxColor: CGFloat = 1
        static let minColor: CGFloat = 0
        
        static let maxIntColor: Int = 255
        static let minIntColor: Int = 0
    }
    
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    // MARK: Lifecycle
    
    init(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        alpha: CGFloat = Constants.maxColor
    ) {
        self.red = min(max(red, Constants.minColor), Constants.maxColor)
        self.green = min(max(green, Constants.minColor), Constants.maxColor)
        self.blue = min(max(blue, Constants.minColor), Constants.maxColor)
        self.alpha = min(max(alpha, Constants.minColor), Constants.maxColor)
    }
    
    init(
        red: Int,
        green: Int,
        blue: Int,
        alpha: Int = Constants.maxIntColor
    ) {
        self.red = CGFloat(
            min(max(red, Constants.minIntColor), Constants.maxIntColor)
        ) / CGFloat(Constants.maxIntColor)
        self.green = CGFloat(
            min(max(green, Constants.minIntColor), Constants.maxIntColor)
        ) / CGFloat(Constants.maxIntColor)
        self.blue = CGFloat(
            min(max(blue, Constants.minIntColor), Constants.maxIntColor)
        ) / CGFloat(Constants.maxIntColor)
        self.alpha = CGFloat(
            min(max(alpha, Constants.minIntColor), Constants.maxIntColor)
        ) / CGFloat(Constants.maxIntColor)
    }
}
