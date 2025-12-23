//
//  CardSideView.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import SwiftUI

// Вью одной стороны карточки со словом
struct CardSideView: View {
    
    private enum Constants {
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity: CGFloat = 0.25
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 6
        
        static let cornerRadius: CGFloat = 16
        static let width: CGFloat = 320
        static let height: CGFloat = 500
        
        static let fontSize: CGFloat = 42
        static let padding: CGFloat = 18
    }

    let text: String
    let palette: Palette
    
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(palette.elementsColor)
            .shadow(
                color: Color.black.opacity(Constants.shadowOpacity),
                radius: Constants.shadowRadius,
                x: Constants.shadowX,
                y: Constants.shadowY
            )
            .overlay(
                Text(text)
                    .font(.system(size: Constants.fontSize, weight: .semibold))
                    .foregroundColor(palette.textColor)
                    .multilineTextAlignment(.center)
                    .padding(Constants.padding)
            )
            .frame(width: Constants.width, height: Constants.height)
    }
}
