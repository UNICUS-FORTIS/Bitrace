//
//  TickerSocketJSONBuilder.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation
import SwiftUI


struct SocketJsonBuilder {
    
    var item: CoinMarketModel
    
    init(item: CoinMarketModel) {
        self.item = item
    }
    
    func build(ticket: String, type: String, level: Int?) -> String? {
        let request = TickerSocketRequest(ticket: ticket,
                                          type: type,
                                          codes: [item.market],
                                          format: "DEFAULT")
        
        if let level = level {
        
            let requestData: [Any] = [
                ["ticket": request.ticket],
                ["type": request.type,
                 "codes": request.codes,
                 "level": level],
                ["format": request.format]
            ]
            
            return makeJson(json: requestData)
            
        } else {
            
            let requestData: [Any] = [
                ["ticket": request.ticket],
                ["type": request.type,
                 "codes": request.codes],
                ["format": request.format]
            ]
            
            return makeJson(json: requestData)
        }
        
        func makeJson(json: [Any]) -> String {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
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
}
