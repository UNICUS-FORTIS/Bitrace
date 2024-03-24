//
//  SearchView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: MainViewModel
    @StateObject var marketViewModel = MarketTickerViewModel.shared
    @StateObject var chartViewModel = ChartViewModel.shared
    @StateObject var orderBookViewModel = OrderBookViewModel.shared
    
    @State private var searchTerm = ""
    @Binding var isSearching: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(filteredCoinMarketArray, id: \.self) { item in
                        NavigationLink(destination:
                                        MarketTickerView(market: item,
                                                         ticker: marketViewModel,
                                                         chart: chartViewModel,
                                                         order: orderBookViewModel)
                                            .navigationBarTitleDisplayMode(.inline)) {
                            MarketItemView(item: item)
                        }
                    }
                }
                .padding()
            }
        }
        .searchable(text: $searchTerm, isPresented: $isSearching)
        .scrollIndicators(.hidden)
    }
    
    private var filteredCoinMarketArray: [CoinMarketModel] {
        guard !searchTerm.isEmpty else {
            return []
        }
        
        return viewModel.coinMarketArray.filter { item in
            item.koreanName.localizedCaseInsensitiveContains(searchTerm) ||
            item.englishName.localizedCaseInsensitiveContains(searchTerm)
        }
    }
}

