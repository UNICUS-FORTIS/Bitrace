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
    
    let market, koreanName, englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(market)
    }
}

