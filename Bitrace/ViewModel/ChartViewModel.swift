//
//  ChartViewModel.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/22/24.
//

import Foundation
import Combine

final class ChartViewModel:ObservableObject {
    
    static let shared = ChartViewModel()
    private init() { }
    
    private let networkService = NetworkService.shared
    private var cancellable = Set<AnyCancellable>()
    
    @Published var candleData:[CandleModel] = []
    
    func fetchCandle(item: CoinMarketModel, unit: Int32 ) {
        let request = CandleRequest(market: item.market, count: 24)
        
        NetworkService.shared.fetchRequest(endpoint: .candle(unit: unit,
                                                             query: request),
                                           decodeModel: [CandleResponse].self)
        .sink { result in
            switch result {
                
            case .finished:
                print(result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] values in
            let sorted = values.sorted { $0.candleDateTimeKst < $1.candleDateTimeKst }
            self?.candleData = sorted.map {
                CandleModel(time: String($0.candleDateTimeKst).dateFormat(),
                            high: Double($0.highPrice),
                            low: Double($0.lowPrice),
                            openPrice: Double($0.openingPrice),
                            tradePrice: Double($0.tradePrice))
            }
        }
        .store(in: &cancellable)
    }
    
    func findMinMaxValues() -> ClosedRange<Double>? {
        guard let firstModel = candleData.first else {
            return nil
        }
        
        var lowestLow = firstModel.low
        var highestHigh = firstModel.high
        
        for model in candleData {
            lowestLow = min(lowestLow, model.low)
            highestHigh = max(highestHigh, model.high)
        }
        
        let range = lowestLow...highestHigh

        return range
    }
}
