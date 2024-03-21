//
//  TickerSocketResponse.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation

struct TickerSocketResponse: Decodable {
    let type, code: String
    let openingPrice, highPrice, lowPrice, tradePrice: Int
    let prevClosingPrice: Int
    let change: String
    let signedChangePrice: Int
    let signedChangeRate: Double
    
    enum CodingKeys: String, CodingKey {
        case type, code
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case change
        case signedChangePrice = "signed_change_price"
        case signedChangeRate = "signed_change_rate"
    }
}
