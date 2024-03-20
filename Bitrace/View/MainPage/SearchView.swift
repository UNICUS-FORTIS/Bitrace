//
//  SearchView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: MainViewModel
    @State private var searchTerm = ""
    @Binding var isSearching: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(filteredCoinMarketArray, id: \.self) { item in
                        NavigationLink(destination: DetailView(coinMarketModel: item)) {
                            MarketItemView(item: item)
                        }
                    }
                }
            }
            .padding()
        }
        .searchable(text: $searchTerm, isPresented: $isSearching)
        .navigationTitle("Market Search")
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

