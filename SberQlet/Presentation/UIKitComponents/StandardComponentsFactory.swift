//
//  StandardComponentsFactory.swift
//  SberQlet
//
//  Created by User on 21.12.2025.
//

import UIKit

// Фабрика для создания стандартных элементов интерфейса
final class StandardComponentsFactory {
    
    private enum Constants {
        static let standardVerticalInsets: CGFloat = 0
        
        static let buttonCornerRadius: CGFloat = 30
        static let buttonTextSize: CGFloat = 32
        static let plus = "+"
    }
    
    // Горизонтальная коллекция наборов(коллекций) слов
    func makeHorisontalCardsCollection(
        cellSize: CGSize,
        spacing: CGFloat,
        horisontalInsets: CGFloat
    ) -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = spacing
        let collection = UICollectionView(
            frame: .null,
            collectionViewLayout: layout
        )
        // Отступы
        collection.contentInset = UIEdgeInsets(
            top: Constants.standardVerticalInsets,
            left: horisontalInsets,
            bottom: Constants.standardVerticalInsets,
            right: horisontalInsets
        )
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        // Регистрируем используемые ячейки
        collection.register(
            CollectionCardViewCell.self,
            forCellWithReuseIdentifier: CollectionCardViewCell.reuseId
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
    
    // Стек коллекций слов
    func makeCollectionsStack(spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    // Стандартный заголовок
    func makeTitle(
        text: String,
        textColor: UIColor?,
        fontSize: CGFloat
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = .systemFont(
            ofSize: fontSize,
            weight: .bold
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // Коллекция слов
    func makeCollectionCard(
        palette: Palette?
    ) -> CollectionCardView {
        let card = CollectionCardView()
        card.textColor = palette?.textUIColor
        card.backgroundColor = palette?.elementsUIColor
        card.wordsCountBackgroundColor = palette?.labelElementsUIColor
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }
    
    // Кнопка добавления чего-либо
    func makePlusButton(
        palette: Palette?
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = palette?.elementsUIColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.setTitle(Constants.plus, for: .normal)
        button.titleLabel?.font = .systemFont(
            ofSize: Constants.buttonTextSize,
            weight: .bold
        )
        button.tintColor = palette?.textUIColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
