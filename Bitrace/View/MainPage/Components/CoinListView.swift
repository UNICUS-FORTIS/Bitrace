//
//  CoinListView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI



func coinListView() -> some View {
    ScrollView {
        VStack(spacing: 10) {
            ForEach(0..<12) { _ in
                Rectangle()
                    .fill(.coinList)
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
    .padding()
}
