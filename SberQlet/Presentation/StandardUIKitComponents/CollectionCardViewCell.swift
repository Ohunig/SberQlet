//
//  CollectionCardViewCell.swift
//  SberQlet
//
//  Created by User on 21.12.2025.
//

import Foundation
import UIKit

// Обёртка над CollectionCardView для использования в коллекции
final class CollectionCardViewCell: UICollectionViewCell {
    static let reuseId = "CardCell"
    
    private enum Constants {
        static let fatalError = "init(coder:) has not been implemented"
    }
    
    var content = CollectionCardView()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    func configure(with content: CollectionCardView) {
        self.content = content
        configureUI()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        content.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(content)
        
        NSLayoutConstraint.activate(
            [
                content.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor
                ),
                content.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor
                ),
                content.topAnchor.constraint(
                    equalTo: contentView.topAnchor
                ),
                content.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor
                )
            ]
        )
    }
}
