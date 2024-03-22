//
//  OrderBookSocketResponse.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation


struct OrderBookSocketResponse: Decodable {
  let timestamp: Int
  let totalAskSize, totalBidSize: Double
  let orderbookUnits: [OrderbookUnit]

  enum CodingKeys: String, CodingKey {
    case timestamp
    case totalAskSize = "total_ask_size"
    case totalBidSize = "total_bid_size"
    case orderbookUnits = "orderbook_units"
  }
}

struct OrderbookUnit: Hashable, Codable {
  let askPrice, bidPrice: Double
  let askSize, bidSize: Double

  enum CodingKeys: String, CodingKey {
    case askPrice = "ask_price"
    case bidPrice = "bid_price"
    case askSize = "ask_size"
    case bidSize = "bid_size"
  }
}

struct OrderbookItem: Hashable, Identifiable {
  let id = UUID()
  let price: Double
  let size: Double
}
