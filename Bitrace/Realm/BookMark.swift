//
//  BookMark.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/23/24.
//


import Foundation
import RealmSwift

final class BookMark: Object {
    
    @Persisted(primaryKey: true) var marketCode: String
    @Persisted var marketName: String
    
    convenience init(code: String, marketName: String) {
        self.init()
        self.marketCode = code
        self.marketName = marketName
    }
}


