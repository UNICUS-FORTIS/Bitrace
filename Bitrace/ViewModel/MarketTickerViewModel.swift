//
//  MarketTickerViewModel.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation
import Combine


final class MarketTickerViewModel: ObservableObject {
    
    static let shared = MarketTickerViewModel()
    private init() { }
    
    @Published
    var currentPrice: String = ""
    var currentMarket: String = ""
    var high: String = ""
    var low: String = ""
    var change: String = ""
    var changePrice: String = ""
    var changePercentage: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    func startSocket(market: CoinMarketModel) {
        
        TickerSocketManager.shared.openWebSocket()
        TickerSocketManager.shared.send()
        
        let builder = TickerSocketJSONBuilder(item: market)
        
        TickerSocketManager.shared.jsonBuilder = builder
        TickerSocketManager.shared.openWebSocket()
        TickerSocketManager.shared.send()
        
        TickerSocketManager.shared.dataObject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self else { return }
                self.currentPrice = String(data.tradePrice.formatted(.number))
                self.currentMarket = data.code
                self.high = String(data.highPrice.formatted(.number))
                self.low = String(data.lowPrice.formatted(.number))
                self.change = data.change
                self.changePrice = String(data.signedChangePrice.formatted(.number))
                self.changePercentage = "\((data.signedChangeRate * 100).formatted(.number.precision(.fractionLength(2))))%"
            }
            .store(in: &cancellable)
    }
    
    func closeWebSocket() {
        currentPrice = ""
        currentMarket = ""
        high = ""
        low = ""
        change = ""
        changePrice = ""
        changePercentage = ""
        TickerSocketManager.shared.closeWebSocket()
    }
}
