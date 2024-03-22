//
//  OrderBookViewModel.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import SwiftUI
import Combine


final class OrderBookViewModel: ObservableObject {
    
    static let shared = OrderBookViewModel()
    private init() { }
    
    @Published var value = 0.0
    @Published var askOrderBook:[OrderbookItem] = [] // 매도
    @Published var bidOrderBook:[OrderbookItem] = [] // 매수
    private var cancellable = Set<AnyCancellable>()
    
    func startSocket(market: CoinMarketModel) {
        
        let builder = SocketJsonBuilder(item: market)
        
        OrderBookSocketManager.shared.jsonBuilder = builder
        OrderBookSocketManager.shared.openWebSocket()
        OrderBookSocketManager.shared.send()
        
        OrderBookSocketManager.shared.orderBookObject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] orderBook in
                guard let self else { return }
                
                let ask = orderBook.orderbookUnits.map { OrderbookItem(price: $0.askPrice, size: $0.askSize) }
                let bid = orderBook.orderbookUnits.map { OrderbookItem(price: $0.bidPrice, size: $0.bidSize) }
                
                self.askOrderBook = ask.sorted { $0.price > $1.price }
                self.bidOrderBook = bid
            }
            .store(in: &cancellable)
    }
    
    func largestAskSize() -> Double {
        return askOrderBook.sorted(by: {$0.size > $1.size}).first!.size
    }
    
    func largestBidSize() -> Double {
        return bidOrderBook.sorted(by: {$0.size > $1.size}).first!.size
    }
    
    func closeWebSocket() {
        askOrderBook = []
        bidOrderBook = []
        OrderBookSocketManager.shared.closeWebSocket()
    }
}
