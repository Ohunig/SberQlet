//
//  TextFieldView.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import SwiftUI

// Текстовое поле для SwiftUI экранов
struct TextFieldView: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 30
        static let height: CGFloat = 70
        
        static let fontSize: CGFloat = 32
        static let horisontalPadding: CGFloat = 30
        
        static let placeholderOpacity: CGFloat = 0.4
    }
    
    @Binding var text: String
    
    let placeholder: String
    let palette: Palette
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(palette.labelElementsColor)

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder).foregroundStyle(
                    palette.textColor.opacity(
                        Constants.placeholderOpacity
                    )
                )
            )
                .font(
                    .system(
                        size: Constants.fontSize,
                        weight: .semibold
                    )
                )
                .foregroundStyle(palette.textColor)
                .padding(.horizontal, Constants.horisontalPadding)
        }
        .frame(height: Constants.height)
    }
}
