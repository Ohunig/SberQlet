//
//  StatisticsScreenPresenter.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation

final class StatisticsScreenPresenter: StatisticsScreenPresentationLogic {
    
    weak var view: StatisticsScreenDisplayLogic?
    
    func presentStart(_ response: Model.Start.Response) {
        var knows = response.knowsNuber
        var doesNotKnow = response.doesNotKnowNumber
        if knows == 0 && doesNotKnow == 0 {
            knows = 1
            doesNotKnow = 1
        }
        view?.displayStart(
            Model.Start.ViewModel(
                palette: (
                    response.palette?[0],
                    response.palette?[1],
                    response.palette?[2],
                    response.palette?[3]
                ),
                knowsNuber: knows,
                doesNotKnowNumber: doesNotKnow
            )
        )
    }
}
