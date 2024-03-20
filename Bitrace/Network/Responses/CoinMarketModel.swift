//
//  CoinMarketModel.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import Foundation

struct CoinMarketModel:Hashable, Decodable {
    
    static func ==(lhs: CoinMarketModel, rhs: CoinMarketModel) -> Bool {
        return lhs.market == rhs.market
    }    
    
    let market, koreanName, englishName, marketWarning: String
    let marketEvent: MarketEvent
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
        case marketWarning = "market_warning"
        case marketEvent = "market_event"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(market)
    }
}

struct MarketEvent: Decodable {
    let warning: Bool
    let caution: Caution
}

struct Caution: Decodable {
    let priceFluctuations, tradingVolumeSoaring, depositAmountSoaring, globalPriceDifferences: Bool
    let concentrationOfSmallAccounts: Bool
    
    enum CodingKeys: String, CodingKey {
        case priceFluctuations = "PRICE_FLUCTUATIONS"
        case tradingVolumeSoaring = "TRADING_VOLUME_SOARING"
        case depositAmountSoaring = "DEPOSIT_AMOUNT_SOARING"
        case globalPriceDifferences = "GLOBAL_PRICE_DIFFERENCES"
        case concentrationOfSmallAccounts = "CONCENTRATION_OF_SMALL_ACCOUNTS"
    }
}

