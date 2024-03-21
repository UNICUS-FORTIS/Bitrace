//
//  TickerSocketJSONBuilder.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation
import SwiftUI


struct TickerSocketJSONBuilder {
    
    var item: CoinMarketModel
    
    init(item: CoinMarketModel) {
        self.item = item
    }
    
    func build() -> String? {
        let request = TickerSocketRequest(ticket: "test example",
                                          type: "ticker",
                                          codes: [item.market],
                                          format: "DEFAULT")
        
        let requestData: [Any] = [
            ["ticket": request.ticket],
            ["type": request.type,
             "codes": request.codes],
            ["format": request.format]
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                return ""
            }
        } catch {
            print("Error: \(error)")
            return ""
        }
    }
}
