//
//  EdgeLightView.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import Foundation
import SwiftUI

struct EdgeLightView: View {
    
    private enum Constants {
        static let glowWidth: CGFloat = 30
        static let blur: CGFloat = 8
        
        static let maxOffset: CGFloat = 1
    }

    // Насколько оттянуто
    let dragOffset: CGFloat
    // Максимальное натяжение
    let maxDistance: CGFloat
    
    let palette: Palette
    
    // Прозрачность правого края
    private var rightOpacity: Double {
        guard dragOffset > 0 else {
            return 0
        }
        return min(Double(dragOffset / maxDistance), Constants.maxOffset)
    }
    
    // Прозрачность левого края
    private var leftOpacity: Double {
        guard dragOffset < 0 else {
            return 0
        }
        return min(Double(-dragOffset / maxDistance), Constants.maxOffset)
    }

    var body: some View {
        ZStack {
            palette.backgroundColor.ignoresSafeArea()

            // Левый край
            HStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.red.opacity(leftOpacity),
                            Color.clear
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: Constants.glowWidth)
                .blur(radius: Constants.blur)
                .blendMode(.screen)

                Spacer()
            }
            .ignoresSafeArea()

            // Правый край
            HStack {
                Spacer()
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.clear,
                            Color.green.opacity(rightOpacity)
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: Constants.glowWidth)
                .blur(radius: Constants.blur)
                .blendMode(.screen)
            }
            .ignoresSafeArea()
        }
    }
}
