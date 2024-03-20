//
//  MarketItemView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import SwiftUI

struct MarketItemView: View {
    
    var item: CoinMarketModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.coinList)
                .frame(height: UIScreen.main.bounds.height * 0.1)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            HStack {
                VStack(alignment: .leading) {
                    Text(item.koreanName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.main)
                    
                    Text(item.englishName)
                        .font(.subheadline)
                        .foregroundStyle(.main)
                }
                .padding(.leading)
                
                Spacer()
                
                Text(item.market)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.main)
                    .padding(.trailing)
            }
        }
    }
}
