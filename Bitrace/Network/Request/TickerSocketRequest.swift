//
//  TickerSocketRequest.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation

struct TickerSocketRequest: Encodable {
    let ticket: String
    let type: String
    let codes: [String]
    let format: String
}
