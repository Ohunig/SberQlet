//
//  MainScreenPresenter.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class MainScreenPresenter: MainScreenPresentationLogic {
    
    weak var view: MainScreenDisplayLogic?
    
    // MARK: Presentations
    
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(
            Model.Start.ViewModel(
                palette: (
                    backgroundColor: response.palette[0],
                    textColor: response.palette[1],
                    elementsColor: response.palette[2],
                    labelElementsColor: response.palette[3]
                )
            )
        )
    }
    
    func presentFetchedData() {
        view?.displayFetchedData()
    }
}
