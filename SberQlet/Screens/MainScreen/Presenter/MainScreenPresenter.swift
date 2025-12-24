//
//  MainScreenPresenter.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class MainScreenPresenter: MainScreenPresentationLogic {
    
    private enum Constants {
        static let standardError: String = "Something went wrong"
    }
    
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
    
    func presentError(_ response: Model.ErrorModels.Response) {
        guard let error: LocalizedError = response.error as? LocalizedError else {
            view?.displayError(
                Model.ErrorModels.ViewModel(
                    errorString: Constants.standardError
                )
            )
            return
        }
        view?.displayError(
            Model.ErrorModels.ViewModel(
                errorString: error.localizedDescription
            )
        )
    }
    
    func presentFetchedData() {
        view?.displayFetchedData()
    }
}
