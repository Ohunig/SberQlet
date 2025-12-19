//
//  MainScreenViewController.swift
//  SberQlet
//
//  Created by User on 17.12.2025.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    private enum Constants {
        static let fatalError = "init(coder:) has not been implemented"
    }
    
    private let interactor: MainScreenBusinessLogic
    
    // Источники данных для экрана
    private let localCollectionsStorage: LocalCollectionsDataAccess
    private let networkCollectionsStorage: NetworkCollectionsDataAccess
    
    private var palette: (
        backgroundColor: UIColor,
        textColor: UIColor,
        elementsColor: UIColor,
        labelElementsColor: UIColor
    )?
    
    // MARK: Lifecycle
    
    init(
        interactor: MainScreenBusinessLogic,
        localCollectionsStorage: LocalCollectionsDataAccess,
        networkCollectionsStorage: NetworkCollectionsDataAccess
    ) {
        self.interactor = interactor
        self.localCollectionsStorage = localCollectionsStorage
        self.networkCollectionsStorage = networkCollectionsStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.loadStart()
        
        configureUI()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        configureCard()
    }
    
    private func configureCard() {
        let card = CollectionCardView()
        card.textColor = palette?.textColor
        card.backgroundColor = palette?.elementsColor
        card.wordsCountBackgroundColor = palette?.labelElementsColor
        card.wordsCount = 5
        card.title = "Test collection"
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        
        NSLayoutConstraint.activate(
            [
                card.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 20
                ),
                card.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 20
                ),
                card.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                )
            ]
        )
    }
}

// MARK: - Display logic extension

extension MainScreenViewController: MainScreenDisplayLogic {
    
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        palette = (
            convertToUIColor(viewModel.palette.backgroundColor),
            convertToUIColor(viewModel.palette.textColor),
            convertToUIColor(viewModel.palette.elementsColor),
            convertToUIColor(viewModel.palette.labelElementsColor)
        )
        view.backgroundColor = palette?.backgroundColor
    }
    
    private func convertToUIColor(_ colors: (ColorModel, ColorModel)?) -> UIColor {
        return UIColor { traitCollection in
            var color: ColorModel?
            if traitCollection.userInterfaceStyle == .light {
                color = colors?.0
            } else {
                color = colors?.1
            }
            guard let color else {
                return .clear
            }
            return UIColor(
                red: color.red,
                green: color.green,
                blue: color.blue,
                alpha: color.alpha
            )
        }
    }
}
