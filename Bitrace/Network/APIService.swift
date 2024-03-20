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


}

extension APIService: TargetType {
    
    var baseURL: URL { URL(string: EndPoints.baseURL)! }
    
    var path: String {
        
        switch self {
            
        case .loadMarkets:
            return Path.marketCodes
        }
        
    }
    
    var method: Moya.Method {
        
        switch self {
            
        case .loadMarkets:
            return .get
        }
        
    }
    
    var task: Moya.Task {
        
        switch self {
            
        case .loadMarkets(let isWarning):
            return .requestParameters(parameters: ["isDetails": isWarning], encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        
        switch self {
            
        case .loadMarkets:
            
            ["Content-Type": "application/json"]
            
        }
        
    }
    
    
    
    
    
    
}
