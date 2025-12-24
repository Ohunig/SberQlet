//
//  ContentView.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import SwiftUI

struct NewCollectionContentView: View {
    
    private enum Constants {
        static let topPadding: CGFloat = 10
        static let horisontalPadding: CGFloat = 20
        
        static let titlesFontSize: CGFloat = 30
        static let titlesBottom: CGFloat = 20
        
        static let firstTitleText = "Название коллекции"
        
        static let secondTitleText = "Список слов"
        static let secondTitleTop: CGFloat = 24
        
        static let nameFieldPlaceholder = "Название"
        
        static let wordsStackSpacing: CGFloat = 10
        
        static let plusButtonText = "+"
        static let addCollectionButtonText = "Готово"
        
        static let addCollectionButtonTop: CGFloat = 40
        
        static let alertTitle = "Ошибка"
        static let alertDismissButton = "ОК"
    }
    
    @ObservedObject var viewModel: NewCollectionViewModel
    
    init(viewModel: NewCollectionViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            viewModel.palette.backgroundColor.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Заголовок
                    HStack {
                        Text(Constants.firstTitleText)
                            .font(
                                .system(
                                    size: Constants.titlesFontSize,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(viewModel.palette.textColor)
                        Spacer()
                    }
                    .padding(.bottom, Constants.titlesBottom)
                    
                    // Плашка ввода названия
                    HStack {
                        TextFieldView(
                            text: $viewModel.name,
                            placeholder: Constants.nameFieldPlaceholder,
                            palette: viewModel.palette
                        )
                    }
                    
                    // Заголовок списка слов
                    HStack {
                        Text(Constants.secondTitleText)
                            .font(
                                .system(
                                    size: Constants.titlesFontSize,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(viewModel.palette.textColor)
                        Spacer()
                    }
                    .padding(.top, Constants.secondTitleTop)
                    .padding(.bottom, Constants.titlesBottom)
                    
                    // Стек слов с переводом
                    wordsStack
                    
                    // Кнопка добавления нового слова
                    ButtonWithTextView(
                        palette: viewModel.palette,
                        text: Constants.plusButtonText
                    ) {
                        print("pressed")
                    }
                    .padding(.top, Constants.wordsStackSpacing)
                    
                    // Кнопка добавления коллекции
                    ButtonWithTextView(
                        palette: viewModel.palette,
                        text: Constants.addCollectionButtonText
                    ) {
                        viewModel.addCollection()
                    }
                    .disabled(
                        viewModel.words.count == 0 || viewModel.name == ""
                    )
                    .padding(.top, Constants.addCollectionButtonTop)
                }
                .padding(.top, Constants.topPadding)
                .padding(.horizontal, Constants.horisontalPadding)
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text(Constants.alertTitle),
                    message: Text(viewModel.errorText),
                    dismissButton: .default(Text(Constants.alertDismissButton))
                )
            }
        }
    }
    
    // Стек слов
    private var wordsStack: some View {
        VStack(spacing: Constants.wordsStackSpacing) {
            ForEach(
                Array(viewModel.words.keys),
                id: \.self
            ) { key in
                WordCardView(
                    word: key,
                    translatedWord: viewModel.words[key] ?? "",
                    palette: viewModel.palette
                )
            }
        }
    }
}
