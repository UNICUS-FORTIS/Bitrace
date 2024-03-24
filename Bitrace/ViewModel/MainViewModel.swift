//
//  MainViewModel.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI
import RealmSwift
import Combine

final class MainViewModel: ObservableObject {
    
    private let networkService = NetworkService.shared
    private var task = RealmRepository.shared.fetchBookmarks()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var coinMarketArray:[CoinMarketModel] = []
    @Published var bitcoinTicker: TickerResponse?
    @Published var storedMarketTickers:[TickerResponse] = []
    
    init() {
        fetchCoinMarket()
        RealmRepository.shared.checkRealmDirectory()
    }
    
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
    
    func fetchTicker(market: String) {
        print(#function)
        networkService.fetchRequest(endpoint: .ticker(market: market),
                                    decodeModel: Ticker.self)
        .sink { result in
            switch result {
                
            case .finished:
                print(result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        } receiveValue: { [weak self] response in
            self?.bitcoinTicker = response.first
            print(response)
        }
        .store(in: &cancellable)
    }
    
    func fetchStoredMarketTickers() {
        var markets: [String] = []
        if task.count > 0 {
            task.forEach { markets.append($0.marketCode) }
        } else {
            self.storedMarketTickers = []
        }
        let combined = markets.joined(separator: ",")
        print("컴바인드", combined)
        networkService.fetchRequest(endpoint: .ticker(market: combined),
                                    decodeModel: Ticker.self )
        .sink { result in
            switch result {
                
            case .finished:
                print(result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        } receiveValue: { [weak self] response in
            self?.storedMarketTickers = response
        }
        .store(in: &cancellable)
    }
    
    func findMarketLink(market: String) -> CoinMarketModel? {
        if let matched = coinMarketArray.first(where: { $0.market == market} ) {
            return matched
        } else {
            return nil
        }
    }
    
    func makeTickerStatusIcon(change: String) -> Image {
        switch change {
        case "RISE":
            return Image(.arrowUp)
            
        case "FALL":
            return Image(.arrowDown)
            
        default: break
        }
        return Image(.horizontal)
    }
    
    func makePriceColor(change: String) -> Color {
        switch change {
        case "RISE":
            return .red
            
        case "FALL":
            return .blue
            
        case "EVEN":
            return .white
            
        default: break
        }
        return .white
    }
}
