//
//  NetworkService.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import Foundation
import Combine
import CombineMoya
import Moya


final class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    let provider = MoyaProvider<APIService>()
    
    func fetchRequest<T: Decodable>(endpoint: APIService, decodeModel: T.Type) -> AnyPublisher<T, Error> {
        return Future { promise in
            self.provider.request(endpoint) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                        promise(.success(decodedData))
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
}
