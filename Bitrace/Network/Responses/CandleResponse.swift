//
//  CandleResponse.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation


struct CandleResponse: Identifiable, Decodable {
    
    let id = UUID().uuidString
    let market, candleDateTimeUTC, candleDateTimeKst: String
    let openingPrice, highPrice, lowPrice, tradePrice: Double
    let timestamp: Int
    let candleAccTradePrice, candleAccTradeVolume: Double
    let unit: Int

    enum CodingKeys: String, CodingKey {
        case market
        case candleDateTimeUTC = "candle_date_time_utc"
        case candleDateTimeKst = "candle_date_time_kst"
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case timestamp
        case candleAccTradePrice = "candle_acc_trade_price"
        case candleAccTradeVolume = "candle_acc_trade_volume"
        case unit
    }
}

typealias Candle = [CandleResponse]


