//
//  CardsStackView.swift
//  SberQlet
//
//  Created by User on 22.12.2025.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    private enum Constants {
        static let swipeToggleValue: CGFloat = 120
        static let offscreenX: CGFloat = 1000
        static let swipeAnimationDuration: Double = 0.28
        static let edgeMaxDistance: CGFloat = 220
        
        static let secondCardScale: CGFloat = 0.95
        static let secondCardOffset: CGFloat = 12
        
        static let dividerHeight: CGFloat = 0.4
        
        static let countTextSize: CGFloat = 32
        static let indicatorsSpacer: CGFloat = 8
        
        static let nullOffsetAnimationResponse: CGFloat = 0.35
        static let nullOffsetAnimationDamping: CGFloat = 0.78
        
        static let finishFontSize: CGFloat = 36
        static let finishTitle = "Результат"

        static let horizontalPadding: CGFloat = 16
        static let countersVerticalPadding: CGFloat = 10
        static let rotationDivisor: CGFloat = 20
        static let cardsSpacerHeight: CGFloat = 160
        static let bottomSpacing: CGFloat = 28

        static let finishedCornerRadius: CGFloat = 14
        static let finishedShadowRadius: CGFloat = 6
        static let finishedDividerHeight: CGFloat = 60

        static let backButtonHeight: CGFloat = 50
        static let topAreaInternalSpacing: CGFloat = 12
        
        // Определён здесь так как используется только на этом экране
        static let mint = Color(red: 135/255, green: 247/255, blue: 222/255)
    }

    @ObservedObject var viewModel: CardsScreenViewModel

    @State private var dragOffset: CGFloat = 0
    @State private var frontCardId: UUID = UUID()
    
    
    // Верхняя карта в колоде
    private var currentCard: Flashcard? {
        let idx = viewModel.currentIndex
        guard idx < viewModel.cards.count else {
            return nil
        }
        return viewModel.cards[idx]
    }
    
    // Карта под верхней в колоде
    private var nextCard: Flashcard? {
        let idx = viewModel.currentIndex + 1
        guard idx < viewModel.cards.count else {
            return nil
        }
        return viewModel.cards[idx]
    }

    // MARK: Body with cards
    
    var body: some View {
        ZStack {
            EdgeLightView(
                dragOffset: dragOffset,
                maxDistance: Constants.edgeMaxDistance,
                palette: viewModel.palette
            )
            // Стек с контентом
            VStack(spacing: 0) {
                topBar
                // Верхняя и следующая за ней карты
                ZStack {
                    if let next = nextCard {
                        FlashcardView(
                            card: next,
                            palette: viewModel.palette
                        )
                        .id(next.id)
                        .scaleEffect(Constants.secondCardScale)
                        .offset(y: Constants.secondCardOffset)
                        .allowsHitTesting(false)
                        .zIndex(0)
                    } else {
                        Color.clear.zIndex(0)
                    }

                    if let current = currentCard {
                        FlashcardView(card: current, palette: viewModel.palette)
                            .id(frontCardId)
                            .offset(x: dragOffset)
                            .rotationEffect(
                                .degrees(dragOffset / Constants.rotationDivisor)
                            )
                            .gesture(dragGesture())
                            .zIndex(1)
                    } else {
                        Spacer(minLength: Constants.cardsSpacerHeight)
                        finishedSummaryView
                            .zIndex(1)
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                
                Spacer().frame(
                    height: Constants.bottomSpacing
                )
            }
        }
        .onChange(of: viewModel.currentIndex) { _, _ in
            dragOffset = 0
        }
    }

    // MARK: Top bar content
    private var topBar: some View {
        VStack(spacing: 0) {
            // Разделитель кнопки и остального контента
            Divider()
                .frame(height: Constants.dividerHeight)
                .background {
                    viewModel.palette.textColor
                }
            
            // Индикаторы количества свайпнутых карт
            if currentCard != nil {
                HStack {
                    SideCardsIndicatorView(
                        number: viewModel.leftCount,
                        color: .red
                    )
                    Spacer()
                    Text("\(min(viewModel.currentIndex + 1, viewModel.cards.count)) / \(viewModel.cards.count)")
                        .font(
                            .system(
                                size: Constants.countTextSize,
                                weight: .bold
                            )
                        )
                        .foregroundColor(viewModel.palette.textColor)
                    Spacer()
                    SideCardsIndicatorView(
                        number: viewModel.rightCount,
                        color: Constants.mint
                    )
                }
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.vertical, Constants.topAreaInternalSpacing)
            } else {
                Spacer().frame(height: Constants.indicatorsSpacer)
            }
        }
        .background(
            Color.clear
        )
    }

    // MARK: Gesture
    // Жест свайпа
    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation.width
            }
            .onEnded { value in
                // Значение с учётом скорости свайпа
                let offset = value.predictedEndTranslation.width

                if abs(offset) > Constants.swipeToggleValue {
                    let direction: CGFloat = offset > 0 ? 1 : -1
                    if direction > 0 {
                        viewModel.rightCount += 1
                    } else {
                        viewModel.leftCount += 1
                    }
                    animateAway(direction: direction)
                } else {
                    withAnimation(
                        .spring(
                            response: Constants.nullOffsetAnimationResponse,
                            dampingFraction: Constants.nullOffsetAnimationDamping
                        )
                    ) {
                        dragOffset = 0
                    }
                }
            }
    }

    // Анимация убирания карты из колоды
    private func animateAway(direction: CGFloat) {
        withAnimation(
            .interactiveSpring(
                response: Constants.nullOffsetAnimationResponse,
                dampingFraction: Constants.nullOffsetAnimationDamping
            )
        ) {
            dragOffset = direction * Constants.offscreenX
        }

        // Ожидание завершения анимации
        DispatchQueue.main.asyncAfter(
            deadline: .now() + Constants.swipeAnimationDuration
        ) {
            // Позволяет отменить все анимации, чтобы не было некорректных дёрганий
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                viewModel.currentIndex += 1
                dragOffset = 0
                frontCardId = UUID()
            }
        }
    }

    // MARK: Summary View
    // После того как пролистали все карты
    private var finishedSummaryView: some View {
        VStack(spacing: 20) {
            Text(Constants.finishTitle)
                .font(.title)
                .bold()
                .foregroundColor(viewModel.palette.textColor)

            HStack(spacing: 24) {
                Text("\(viewModel.leftCount)")
                    .font(
                        .system(
                            size: Constants.finishFontSize,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.red)

                Divider()
                    .frame(height: Constants.finishedDividerHeight)
                    .background(viewModel.palette.textColor)

                Text("\(viewModel.rightCount)")
                    .font(
                        .system(
                            size: Constants.finishFontSize,
                            weight: .bold
                        )
                    )
                    .foregroundColor(Constants.mint)
            }
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.finishedCornerRadius
                )
                .fill(viewModel.palette.elementsColor).shadow(
                    radius: Constants.finishedShadowRadius
                )
            )
        }
        .padding()
    }
}

