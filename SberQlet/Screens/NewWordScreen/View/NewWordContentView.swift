//
//  NewWordContentView.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import SwiftUI

struct NewWordContentView: View {
    
    private enum Constants {
        static let topPadding: CGFloat = 10
        static let horisontalPadding: CGFloat = 20
        
        static let titleText: String = "Введите данные"
        static let titleFontSize: CGFloat = 30
        static let titleBottom: CGFloat = 20
        
        static let wordFieldPlaceholder = "Слово"
        static let translationFieldPlaceholder = "Перевод"
        
        static let translationFieldTop: CGFloat = 10
        
        static let addWordButtonText = "Добавить"
        static let addWordButtonTop: CGFloat = 40
    }
    
    @ObservedObject var viewModel: NewWordViewModel
    
    var body: some View {
        ZStack {
            viewModel.palette.backgroundColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Заголовок
                    HStack {
                        Text(Constants.titleText)
                            .font(
                                .system(
                                    size: Constants.titleFontSize,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(viewModel.palette.textColor)
                        Spacer()
                    }
                    .padding(.bottom, Constants.titleBottom)
                    
                    // Первое текстовое поле
                    TextFieldView(
                        text: $viewModel.word,
                        placeholder: Constants.wordFieldPlaceholder,
                        palette: viewModel.palette
                    )
                    
                    // Второе текстовое поле
                    TextFieldView(
                        text: $viewModel.translation,
                        placeholder: Constants.translationFieldPlaceholder,
                        palette: viewModel.palette
                    )
                    .padding(.top, Constants.translationFieldTop)
                    
                    // Кнопка добавления слова
                    ButtonWithTextView(
                        palette: viewModel.palette,
                        text: Constants.addWordButtonText
                    ) {
                        viewModel.addWord()
                    }
                    .padding(.top, Constants.addWordButtonTop)
                    .disabled(
                        viewModel.word == "" || viewModel.translation == ""
                    )
                }
                .padding(.top, Constants.topPadding)
                .padding(.horizontal, Constants.horisontalPadding)
            }
        }
    }
}
