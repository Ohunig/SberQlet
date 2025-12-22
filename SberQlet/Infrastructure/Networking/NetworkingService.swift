//
//  NetworkingService.swift
//  SberQlet
//
//  Created by User on 18.12.2025.
//

import Foundation

final class NetworkingService: NetworkingLogic {
    
    private enum Constants {
        nonisolated static let validStatusCodes = 200..<300
    }
    
    func fetchData(
        from url: URL,
        completion: @escaping @Sendable (Result<Data, any Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Проверка всех крайних случаев
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            guard Constants.validStatusCodes.contains(urlResponse.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            guard let data else {
                completion(.failure(NetworkingError.incorrectData))
                return
            }
            // Все проверки прошли успешно
            completion(.success(data))
        }.resume()
    }
}
