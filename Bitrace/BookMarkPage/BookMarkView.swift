//
//  BookMarkView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/24/24.
//

import SwiftUI

struct BookMarkView: View {
    
    @StateObject var viewModel: MainViewModel
    @StateObject var marketViewModel = MarketTickerViewModel.shared
    @StateObject var chartViewModel = ChartViewModel.shared
    @StateObject var orderBookViewModel = OrderBookViewModel.shared
    @State private var searchTerm = ""
    @Binding var isFavoriteSearching: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(filteredStoredMarket, id: \.market) { item in
                        if let market = viewModel.findMarketLink(market: item.market) {
                            NavigationLink(destination:
                                            MarketTickerView(market: market,
                                                             ticker: marketViewModel,
                                                             chart: chartViewModel,
                                                             order: orderBookViewModel)
                                                .navigationBarTitleDisplayMode(.inline)) {
                                MarketItemView(item: market)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .searchable(text: $searchTerm, isPresented: $isFavoriteSearching)
        .scrollIndicators(.hidden)
    }
    
    private var filteredStoredMarket: [TickerResponse] {
        guard !searchTerm.isEmpty else {
            return []
        }
        
        return viewModel.storedMarketTickers.filter { item in
            if let market = viewModel.findMarketLink(market: item.market) {
                let filtered = market.koreanName.localizedCaseInsensitiveContains(searchTerm) ||
                market.englishName.localizedCaseInsensitiveContains(searchTerm)
                return filtered
            } else {
                return false
            }
        }
    }
}
