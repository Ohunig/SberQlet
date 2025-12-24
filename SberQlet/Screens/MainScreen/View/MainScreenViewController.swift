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
        
        static let horisontalPadding: CGFloat = 20
        
        static let titlesFontSize: CGFloat = 30
        static let popularCollectionsText = "Популярные коллекции"
        static let localCollectionsText = "Мои коллекции"
        
        static let localTitleTop: CGFloat = 24
        
        static let collectionSpacing: CGFloat = 10
        static let collectionTop: CGFloat = 20
        static let collectionHeight: CGFloat = 150
        static let collectionHorisontalInsets: CGFloat = 20
        static let collectionCellSize = CGSize(width: 350, height: 150)
        
        static let stackSpacing: CGFloat = 10
        static let stackTop: CGFloat = 20
        
        static let plusButtonHeight: CGFloat = 60
        static let plusButtonBottom: CGFloat = 20
        
        static let errorTitle: String = "Ошибка"
        static let errorOkButton: String = "Ок"
    }
    
    // MARK: Properties
    
    private let interactor: MainScreenBusinessLogic
    
    // Источники данных для экрана
    private let localCollectionsStorage: LocalCollectionsDataAccess
    private let networkCollectionsStorage: NetworkCollectionsDataAccess
    
    // Фабрика компонентов. Не через протокол так как
    // вью контроллер unit-тестами не тестируется
    private let componentsFactory: StandardComponentsFactory
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.delaysContentTouches = false
        view.alwaysBounceVertical = true
        return view
    }()
    
    private lazy var collectionView = componentsFactory.makeHorisontalCardsCollection(
        cellSize: Constants.collectionCellSize,
        spacing: Constants.collectionSpacing,
        horisontalInsets: Constants.collectionHorisontalInsets
    )
    
    private lazy var cardsStack: UIStackView = componentsFactory.makeCollectionsStack(
        spacing: Constants.stackSpacing
    )
    
    private lazy var plusButton: UIButton = componentsFactory.makePlusButton(
        palette: palette
    )
    
    private lazy var popularCollectionsLabel = componentsFactory.makeTitle(
        text: Constants.popularCollectionsText,
        textColor: palette?.textUIColor,
        fontSize: Constants.titlesFontSize
    )
    
    private lazy var localCollectionsLabel = componentsFactory.makeTitle(
        text: Constants.localCollectionsText,
        textColor: palette?.textUIColor,
        fontSize: Constants.titlesFontSize
    )
    
    private var palette: Palette?
    
    // MARK: Lifecycle
    
    init(
        interactor: MainScreenBusinessLogic,
        localCollectionsStorage: LocalCollectionsDataAccess,
        networkCollectionsStorage: NetworkCollectionsDataAccess,
        componentsFactory: StandardComponentsFactory
    ) {
        self.interactor = interactor
        self.localCollectionsStorage = localCollectionsStorage
        self.networkCollectionsStorage = networkCollectionsStorage
        self.componentsFactory = componentsFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Загружаем всё что нужно для правильного отображения экрана
        interactor.loadStart()
        // Настраиваем UI
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.fetchData()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        configureScrollView()
        configurePopularCollectionsLabel()
        configureHorisontalCollections()
        configureLocalCollectionsLabel()
        configureCollectionsStack()
        configurePlusButton()
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(
                    equalTo: view.topAnchor
                ),
                scrollView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor
                ),
                scrollView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor
                ),
                scrollView.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor
                )
            ]
        )
    }
    
    private func configurePopularCollectionsLabel() {
        scrollView.addSubview(popularCollectionsLabel)
        
        NSLayoutConstraint.activate(
            [
                popularCollectionsLabel.topAnchor.constraint(
                    equalTo: scrollView.contentLayoutGuide.topAnchor
                ),
                popularCollectionsLabel.leadingAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.leadingAnchor,
                    constant: Constants.horisontalPadding
                ),
                popularCollectionsLabel.centerXAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.centerXAnchor
                )
            ]
        )
    }
    
    private func configureHorisontalCollections() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        scrollView.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.leadingAnchor
                ),
                collectionView.trailingAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.trailingAnchor
                ),
                collectionView.topAnchor.constraint(
                    equalTo: popularCollectionsLabel.bottomAnchor,
                    constant: Constants.collectionTop
                ),
                collectionView.heightAnchor.constraint(
                    equalToConstant: Constants.collectionHeight
                )
            ]
        )
    }
    
    private func configureLocalCollectionsLabel() {
        scrollView.addSubview(localCollectionsLabel)
        
        NSLayoutConstraint.activate(
            [
                localCollectionsLabel.topAnchor.constraint(
                    equalTo: collectionView.bottomAnchor,
                    constant: Constants.localTitleTop
                ),
                localCollectionsLabel.leadingAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.leadingAnchor,
                    constant: Constants.horisontalPadding
                ),
                localCollectionsLabel.centerXAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.centerXAnchor
                )
            ]
        )
    }
    
    private func configureCollectionsStack() {
        scrollView.addSubview(cardsStack)
        
        NSLayoutConstraint.activate(
            [
                cardsStack.topAnchor.constraint(
                    equalTo: localCollectionsLabel.bottomAnchor,
                    constant: Constants.stackTop
                ),
                cardsStack.centerXAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.centerXAnchor
                ),
                cardsStack.leadingAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.leadingAnchor,
                    constant: Constants.horisontalPadding
                )
            ]
        )
    }
    
    private func configurePlusButton() {
        plusButton.addTarget(
            self,
            action: #selector(plusButtonTapped),
            for: .touchUpInside
        )
        scrollView.addSubview(plusButton)
        
        NSLayoutConstraint.activate(
            [
                plusButton.heightAnchor.constraint(
                    equalToConstant: Constants.plusButtonHeight
                ),
                plusButton.leadingAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.leadingAnchor,
                    constant: Constants.horisontalPadding
                ),
                plusButton.centerXAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.centerXAnchor
                ),
                plusButton.topAnchor.constraint(
                    equalTo: cardsStack.bottomAnchor,
                    constant: Constants.stackSpacing
                ),
                plusButton.bottomAnchor.constraint(
                    equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                    constant: -Constants.plusButtonBottom
                )
            ]
        )
    }
    
    // MARK: Reload Stack
    
    private func reloadStack() {
        for i in cardsStack.subviews.count..<localCollectionsStorage.localCollectionsCount {
            let card = componentsFactory.makeCollectionCard(palette: palette)
            card.title = localCollectionsStorage.getLocalCollectionInfo(
                index: i
            )?.name
            card.wordsCount = localCollectionsStorage.getLocalCollectionInfo(
                index: i
            )?.wordsCount
            card.tag = i
            // Добавляем реакцию на нажатия
            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(stackCardTapped(_:))
            )
            card.addGestureRecognizer(tap)
            cardsStack.addArrangedSubview(card)
        }
    }
    
    // MARK: Tap processing
    
    @objc
    private func stackCardTapped(_ recognizer: UITapGestureRecognizer) {
        guard let view = recognizer.view else { return }
        let index = view.tag
        interactor.goToCardsScreen(
            Model.GoToCardsScreen.Request(
                index: index,
                fromLocal: true
            )
        )
    }
    
    @objc
    private func plusButtonTapped() {
        interactor.goToNewCollectionScreen()
    }
}

// MARK: - Display logic extension

extension MainScreenViewController: MainScreenDisplayLogic {
    
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        palette = Palette(
            backgroundColor: viewModel.palette.backgroundColor,
            textColor: viewModel.palette.textColor,
            elementsColor: viewModel.palette.elementsColor,
            labelElementsColor: viewModel.palette.labelElementsColor
        )
        view.backgroundColor = palette?.backgroundUIColor
    }
    
    func displayError(_ viewModel: Model.ErrorModels.ViewModel) {
        let alert = UIAlertController(
            title: Constants.errorTitle,
            message: viewModel.errorString,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: Constants.errorOkButton,
                style: .default,
                handler: nil
            )
        )
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayFetchedData() {
        collectionView.reloadData()
        reloadStack()
    }
}

// MARK: - Collection data source extension

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        networkCollectionsStorage.networkCollectionsCount
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        // Получаем ячейку
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCardViewCell.reuseId,
            for: indexPath
        ) as! CollectionCardViewCell
        
        // Настраиваем карточку
        let card = componentsFactory.makeCollectionCard(palette: palette)
        card.title = networkCollectionsStorage.getNetworkCollectionInfo(
            index: indexPath.row
        )?.name
        card.wordsCount = networkCollectionsStorage.getNetworkCollectionInfo(
            index: indexPath.row
        )?.wordsCount
        
        // Настраиваем ячейку
        cell.configure(with: card)
        
        return cell
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        interactor.goToCardsScreen(
            Model.GoToCardsScreen.Request(
                index: indexPath.row,
                fromLocal: false
            )
        )
    }
}
