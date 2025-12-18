//
//  NetworkingLogic.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

// Ошибки связанные с работой с сетью
enum NetworkingError: Error {
    // Некорректные данные (nil)
    case incorrectData
}

// Расширение с описанием ошибок
extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .incorrectData:
            "Data from server is not correct"
        }
    }
}

// Логика работы с сетью
protocol NetworkingLogic: AnyObject {
    
    // Подтягивает данные по адресу
    func fetchData(
        from url: URL,
        completion: @escaping @Sendable (Result<Data, Error>) -> Void
    )
}
