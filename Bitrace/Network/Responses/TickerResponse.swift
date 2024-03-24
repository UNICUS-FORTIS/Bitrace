//
//  TickerResponse.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import Foundation

typealias Ticker = [TickerResponse]

struct TickerResponse: Decodable {
    let market, tradeDate, tradeTime, tradeDateKst: String
    let tradeTimeKst: String
    let tradeTimestamp, openingPrice, highPrice, lowPrice: Int
    let tradePrice, prevClosingPrice: Int
    let change: String
    let changePrice: Int
    let changeRate: Double
    let signedChangePrice: Int
    let signedChangeRate: Double
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case market
        case tradeDate = "trade_date"
        case tradeTime = "trade_time"
        case tradeDateKst = "trade_date_kst"
        case tradeTimeKst = "trade_time_kst"
        case tradeTimestamp = "trade_timestamp"
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case change
        case changePrice = "change_price"
        case changeRate = "change_rate"
        case signedChangePrice = "signed_change_price"
        case signedChangeRate = "signed_change_rate"
        case timestamp
    }
}
