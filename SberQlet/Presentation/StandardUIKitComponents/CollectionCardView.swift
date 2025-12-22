//
//  CollectionCard.swift
//  SberQlet
//
//  Created by User on 19.12.2025.
//

import UIKit

final class CollectionCardView: UIView {
    
    private enum Constants {
        static let fatalError = "init(coder:) has not been implemented"
        
        // Константы главного view
        // height задаём жёстко потому что хочу всегда одну высоту
        static let heigh: CGFloat = 150
        static let cornerRadius: CGFloat = 30
        
        // Отступы по вертикали и горизонтали
        static let horisontalPadding: CGFloat = 30
        static let verticalPaddings: CGFloat = 25
        
        // Константы заголовка
        static let titleTextSize: CGFloat = 32
        
        // Константы числа слов
        static let wordsCountText = "words"
        static let wordsCountTextSize: CGFloat = 22
        static let wordsCountCornerRadius: CGFloat = 15
        static let wordsCountVerticalPadding: CGFloat = 4
        static let wordsCountHorisontalPadding: CGFloat = 10
        
    }
    
    private let titleLabel = UILabel()
    
    private let countWrapper = UIView()
    private let wordsCountLabel = UILabel()
    
    // Cвойства для настройки текста извне
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var wordsCount: Int? {
        didSet {
            wordsCountLabel.text = "\(wordsCount ?? 0) \(Constants.wordsCountText)"
        }
    }
    
    // Свойства для настройки цветов извне
    
    var wordsCountBackgroundColor: UIColor? {
        didSet {
            countWrapper.backgroundColor = wordsCountBackgroundColor
        }
    }
    
    var textColor: UIColor? {
        didSet {
            titleLabel.textColor = textColor
            wordsCountLabel.textColor = textColor
        }
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        configureView()
        configureTitle()
        configureWordsCount()
    }
    
    private func configureView() {
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(equalToConstant: Constants.heigh)
            ]
        )
    }
    
    private func configureTitle() {
        titleLabel.font = .systemFont(
            ofSize: Constants.titleTextSize,
            weight: .semibold
        )
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(
                    equalTo: self.topAnchor,
                    constant: Constants.verticalPaddings
                ),
                titleLabel.leadingAnchor.constraint(
                    equalTo: self.leadingAnchor,
                    constant: Constants.horisontalPadding
                ),
                titleLabel.trailingAnchor.constraint(
                    equalTo: self.trailingAnchor,
                    constant: -Constants.horisontalPadding
                )
            ]
        )
    }
    
    private func configureWordsCount() {
        // Настройка текста
        wordsCountLabel.font = .systemFont(
            ofSize: Constants.wordsCountTextSize,
            weight: .medium
        )
        wordsCountLabel.backgroundColor = .clear
        wordsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        countWrapper.addSubview(wordsCountLabel)
        
        // Настройка окружения текста
        countWrapper.layer.cornerRadius = Constants.wordsCountCornerRadius
        countWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(countWrapper)
        
        NSLayoutConstraint.activate(
            [
                wordsCountLabel.leadingAnchor.constraint(
                    equalTo: countWrapper.leadingAnchor,
                    constant: Constants.wordsCountHorisontalPadding
                ),
                wordsCountLabel.centerXAnchor.constraint(
                    equalTo: countWrapper.centerXAnchor
                ),
                wordsCountLabel.topAnchor.constraint(
                    equalTo: countWrapper.topAnchor,
                    constant: Constants.wordsCountVerticalPadding
                ),
                wordsCountLabel.centerYAnchor.constraint(
                    equalTo: countWrapper.centerYAnchor
                ),
                
                countWrapper.leadingAnchor.constraint(
                    equalTo: self.leadingAnchor,
                    constant: Constants.horisontalPadding
                ),
                countWrapper.bottomAnchor.constraint(
                    equalTo: self.bottomAnchor,
                    constant: -Constants.verticalPaddings
                )
            ]
        )
    }
}
