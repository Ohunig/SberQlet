//
//  StatisticViewController.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    private enum Constants {
        static let fatalError = "init(coder:) has not been implemented"
        
        static let horisontalPadding: CGFloat = 20
        
        static let titleText = "Статистика"
        static let titlesFontSize: CGFloat = 30
        
        static let pieChartTop: CGFloat = 70
        static let pieChartHeight: CGFloat = 300
        
        static let mint = UIColor(red: 135/255, green: 247/255, blue: 222/255, alpha: 1)
    }
    
    private let interactor: StatisticsScreenBusinessLogic
    
    private let componentsFactory: StandardComponentsFactory
    
    private var palette: Palette = Palette()
    
    private var statistics: (know: Int, doNotKnow: Int) = (0, 0)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.delaysContentTouches = false
        view.alwaysBounceVertical = true
        return view
    }()
    
    private lazy var titleLabel = componentsFactory.makeTitle(
        text: Constants.titleText,
        textColor: palette.textUIColor,
        fontSize: Constants.titlesFontSize
    )
    
    private var pieChart = PieChartView()
    
    // MARK: Lifecycle
    
    init(
        interactor: StatisticsScreenBusinessLogic,
        componentsFactory: StandardComponentsFactory
    ) {
        self.interactor = interactor
        self.componentsFactory = componentsFactory
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
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.loadStart()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        configureScrollView()
        configureLabel()
        configurePieChart()
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
    
    private func configureLabel() {
        scrollView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(
                    equalTo: scrollView.contentLayoutGuide.topAnchor
                ),
                titleLabel.leadingAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.leadingAnchor,
                    constant: Constants.horisontalPadding
                ),
                titleLabel.centerXAnchor.constraint(
                    equalTo: scrollView.frameLayoutGuide.centerXAnchor
                )
            ]
        )
    }
    
    private func configurePieChart() {
        // Чтобы по умолчанию было 50 / 50
        pieChart.slices = [
            PieSlice(value: 1, color: Constants.mint),
            PieSlice(value: 1, color: .red)
        ]
        pieChart.layer.shadowColor = UIColor.black.cgColor
        pieChart.layer.shadowOffset = .zero
        pieChart.layer.shadowRadius = 20
        pieChart.layer.shadowOpacity = 0.3
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(pieChart)
        
        NSLayoutConstraint.activate(
            [
                pieChart.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.horisontalPadding
                ),
                pieChart.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.horisontalPadding
                ),
                pieChart.topAnchor.constraint(
                    equalTo: titleLabel.bottomAnchor,
                    constant: Constants.pieChartTop
                ),
                pieChart.heightAnchor.constraint(
                    equalToConstant: Constants.pieChartHeight
                )
            ]
        )
    }
}

// MARK: Display logic extension

extension StatisticsViewController: StatisticsScreenDisplayLogic {
    
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        statistics = (viewModel.knowsNuber, viewModel.doesNotKnowNumber)
        // Обновляем диаграмму
        pieChart.slices = [
            PieSlice(value: CGFloat(statistics.know), color: Constants.mint),
            PieSlice(value: CGFloat(statistics.doNotKnow), color: .red)
        ]
        guard viewModel.palette.backgroundColor != nil && viewModel.palette.textColor != nil && viewModel.palette.elementsColor != nil && viewModel.palette.labelElementsColor != nil
        else { return }
        // Так как уже проверили
        palette = Palette(
            backgroundColor: viewModel.palette.backgroundColor!,
            textColor: viewModel.palette.textColor!,
            elementsColor: viewModel.palette.elementsColor!,
            labelElementsColor: viewModel.palette.labelElementsColor!
        )
        view.backgroundColor = palette.backgroundUIColor
    }
}
