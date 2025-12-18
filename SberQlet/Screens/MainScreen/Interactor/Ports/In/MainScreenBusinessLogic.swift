//
//  MainScreenBusinessLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

protocol MainScreenBusinessLogic: AnyObject {
    typealias Model = MainScreenModels
    
    var collectionsCount: Int { get }
    
    func getCollectionInfo(index: Int) -> (String)
    
    // Загрузка начальных настроек экрана
    func loadStart()
}
