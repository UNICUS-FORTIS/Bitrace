//
//  MainViewModel.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    private let networkService = NetworkService.shared
    private var cancellable = Set<AnyCancellable>()

    @Published var coinMarketArray:[CoinMarketModel] = []
    
    func fetchCoinMarket() {
        print(#function, "네트워크 통신 시작함")
        networkService.fetchRequest(endpoint: .loadMarkets(warning: true), decodeModel: [CoinMarketModel].self)
            .sink { result in
                switch result {
                    
                case .finished:
                    print(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] values in
                self?.coinMarketArray = values
            }
            .store(in: &cancellable)
    }
}
