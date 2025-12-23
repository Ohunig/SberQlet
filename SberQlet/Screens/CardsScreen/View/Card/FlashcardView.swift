//
//  FlashcardView.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import Foundation
import SwiftUI

// Вью поворачивающейся карточки
struct FlashcardView: View {
    
    private enum Constants {
        static let flipDuration: Double = 0.30
        static let flipDegrees: CGFloat = 180
        static let axis: (x: CGFloat, y: CGFloat, z: CGFloat) = (x: 0, y: 1, z: 0)
        
        static let entireCircle: CGFloat = 360
        static let rightAngle: CGFloat = 90
    }

    let card: Flashcard
    let palette: Palette
    
    @State private var rotation: Double = 0
    
    private var normalizedRotation: Double {
        var nr = rotation.truncatingRemainder(dividingBy: Constants.entireCircle)
        if nr < 0 {
            nr += Constants.entireCircle
        }
        return nr
    }
    
    private var frontOpacity: Double {
        let rotation = normalizedRotation
        // Если < 90 или > 270, тогда видим переднюю сторону
        return (
            rotation < Constants.rightAngle || rotation > (
                Constants.entireCircle - Constants.rightAngle
            )
        ) ? 1 : 0
    }
    
    private var backOpacity: Double {
        let rotation = normalizedRotation
        // Аналогично передней стороне, только наоборот
        return (
            rotation > Constants.rightAngle && rotation < (
                Constants.entireCircle - Constants.rightAngle
            )
        ) ? 1 : 0
    }

    var body: some View {
        ZStack {
            CardSideView(
                text: card.front,
                palette: palette
            )
            .rotation3DEffect(
                .degrees(rotation),
                axis: Constants.axis
            )
            .opacity(frontOpacity)

            CardSideView(
                text: card.back,
                palette: palette
            )
            .rotation3DEffect(
                .degrees(rotation + Constants.flipDegrees),
                axis: Constants.axis
            )
            .opacity(backOpacity)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: Constants.flipDuration)) {
                rotation += Constants.flipDegrees
            }
        }
    }

}
