//
//  PlusButton.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import SwiftUI

// Кнопка добавления чего-либо для SwiftUI экранов
struct ButtonWithTextView: View {
    
    private enum Constants {
        static let buttonHeight: CGFloat = 60
        static let buttonCornerRadius: CGFloat = 30
        static let buttonTextSize: CGFloat = 32
        static let pressedButtonOpacity: CGFloat = 0.8
    }
    
    let palette: Palette
    let text: String
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.buttonCornerRadius)
                    .fill(palette.elementsColor)
                
                HStack {
                    Spacer()
                    Text(text)
                        .font(
                            .system(
                                size: Constants.buttonTextSize,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(palette.textColor)
                    Spacer()
                }
            }
        }
        .frame(height: Constants.buttonHeight)
    }
}
