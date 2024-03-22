//
//  OrderBookSocketRequest.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation


struct OrderBookSocketRequest: Encodable {

    let ticket: String
    let type: String
    let codes: [String]
    
}

typealias OrderBookRequest = [OrderBookSocketRequest]
