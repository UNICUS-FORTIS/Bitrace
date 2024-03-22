//
//  CandleRequest.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/22/24.
//

import Foundation


struct CandleRequest: Encodable {
    
    let market: String
    let count: Int32
    
}
