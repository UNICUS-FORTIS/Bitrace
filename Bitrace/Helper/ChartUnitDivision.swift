//
//  ChartUnitDivision.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import Foundation


enum ChartUnitDivision: String, CaseIterable {

    case oneMinute = "1분"
    case fiveMinute = "3분"
    case tenMinute = "10분"
    case halfHour = "30분"
    case oneHour = "60분"
    
    var unitRawValue: Int {
        
        switch self {
        case .oneMinute:
            return 1
        case .fiveMinute:
            return 5
        case .tenMinute:
            return 10
        case .halfHour:
            return 30
        case .oneHour:
            return 60
        }
    }
    
}
