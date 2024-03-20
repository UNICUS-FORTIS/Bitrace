//
//  APIService.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import Foundation
import Moya

enum APIService {
    
    case loadMarkets(warning: Bool)
    case ticker(market: String)


}

extension APIService: TargetType {
    
    var baseURL: URL { URL(string: EndPoints.baseURL)! }
    
    var path: String {
        
        switch self {
            
        case .loadMarkets:
            return Path.marketCodes
            
        case .ticker:
            return Path.ticker
            
        }
        
    }
    
    var method: Moya.Method {
        
        switch self {
            
        case .loadMarkets,
                .ticker:
            return .get
        }
        
    }
    
    var task: Moya.Task {
        
        switch self {
            
        case .loadMarkets(let isWarning):
            return .requestParameters(parameters: ["isDetails": isWarning], encoding: URLEncoding.queryString)
            
        case .ticker(let market):
            return .requestParameters(parameters: ["markets": market],
                                      encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        
        switch self {
            
        case .loadMarkets:
            
            ["Content-Type": "application/json"]
            
        case .ticker:
            
            ["accept": "application/json"]
            
        }
        
    }
    
    
    
    
    
    
}
