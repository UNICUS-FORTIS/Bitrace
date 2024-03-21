//
//  MarketListView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI


struct MarketListView: View {
    
    @StateObject var viewModel: MainViewModel
    @StateObject var marketViewModel = MarketTickerViewModel.shared
    
    var body: some View {
        
        LazyVStack(spacing: 10) {
            ForEach(viewModel.coinMarketArray, id: \.self) { item in
                NavigationLink(destination: MarketTickerView(market: item,
                                                             viewModel: marketViewModel)) {
                    MarketItemView(item: item)
                }
            }
        }
        .padding()
    }
}
