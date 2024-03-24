//
//  CandleModel.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation


struct CandleModel: Identifiable, Comparable {
    let id = UUID().uuidString
    let time: String
    let high: Double
    let low: Double
    let openPrice: Double
    let tradePrice: Double
    
    static func < (lhs: CandleModel, rhs: CandleModel) -> Bool {
        return lhs.time < rhs.time
    }
    
    static func == (lhs: CandleModel, rhs: CandleModel) -> Bool {
        return lhs.time == rhs.time
    }
}
