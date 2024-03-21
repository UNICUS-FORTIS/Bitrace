//
//  String+Extension.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/22/24.
//

import Foundation

extension String {
    
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: self) ?? Date()
        
        dateFormatter.dateFormat = "H:mm"
        return dateFormatter.string(from: date)
    }
}
