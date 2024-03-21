//
//  Int+Extension.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/22/24.
//

import Foundation

extension Int {
    func intFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1

        if self >= 1000 {
            formatter.maximumFractionDigits = 0
            formatter.multiplier = 0.001
            formatter.positiveSuffix = "K"
        }

        if let formattedString = formatter.string(for: self) {
            return formattedString
        } else {
            return "\(self)"
        }
    }
}
