//
//  WordCardView.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import SwiftUI

struct WordCardView: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 30
        
        static let fontSize: CGFloat = 32
        static let horisontalPadding: CGFloat = 30
        static let verticalPadding: CGFloat = 25
        
        static let dividerHeight: CGFloat = 0.5
    }
    
    let word: String
    let translatedWord: String
    let palette: Palette
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(palette.elementsColor)
            
            VStack(alignment: .leading) {
                Text(word)
                    .font(
                        .system(
                            size: Constants.fontSize,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(palette.textColor)
                    .padding(.horizontal, Constants.horisontalPadding)
                    .padding(.top, Constants.verticalPadding)
                
                Divider()
                    .frame(height: Constants.dividerHeight)
                    .background {
                        palette.textColor
                    }
                
                Text(translatedWord)
                    .font(
                        .system(
                            size: Constants.fontSize,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(palette.textColor)
                    .padding(.horizontal, Constants.horisontalPadding)
                    .padding(.bottom, Constants.verticalPadding)
            }
        }
    }
}
