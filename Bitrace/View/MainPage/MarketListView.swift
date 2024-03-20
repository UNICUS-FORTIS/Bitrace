//
//  MarketListView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI


struct MarketListView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        
        LazyVStack(spacing: 10) {
            ForEach(viewModel.coinMarketArray, id: \.self) { item in
                NavigationLink(destination: DetailView(coinMarketModel: item)) {
                    MarketItemView(item: item)
                }
            }
        }
        .padding()
    }
}

