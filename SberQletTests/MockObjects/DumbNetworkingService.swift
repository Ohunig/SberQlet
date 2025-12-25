//
//  DumbNetworkingService.swift
//  SberQletTests
//
//  Created by User on 25.12.2025.
//

import Foundation
@testable import SberQlet

final class DumbNetworkingService: NetworkingLogic {
    
    var hasError = false
    
    var fetched: Int = 0
    
    func fetchData(from url: URL, completion: @escaping @Sendable (Result<Data, any Error>) -> Void) {
        if (hasError) {
            completion(.failure(NetworkingError.incorrectData))
            return
        }
        completion(.success(Data()))
    }
}
