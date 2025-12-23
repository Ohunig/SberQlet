//
//  SideCardsIndicatorView.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import Foundation
import SwiftUI

// Боковой индикатор количества свайпнутых слов (зелёный и красный индикаторы)
struct SideCardsIndicatorView: View {
    
    private enum Constants {
        static let numberFontSize: CGFloat = 18
        static let paddingH: CGFloat = 20
        static let paddingV: CGFloat = 8
        static let cornerRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 6
        static let titleFontSize: CGFloat = 12
        
        static let shadowOpacity: CGFloat = 0.2
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 4
    }

    let number: Int
    let color: Color

    var body: some View {
        Text("\(number)")
            .font(.system(size: Constants.numberFontSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, Constants.paddingH)
            .padding(.vertical, Constants.paddingV)
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(color)
                    .shadow(
                        color: color.opacity(Constants.shadowOpacity),
                        radius: Constants.shadowRadius,
                        x: Constants.shadowX,
                        y: Constants.shadowY
                    )
            )
    }
}
