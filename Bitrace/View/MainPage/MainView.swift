//
//  ContentView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/16/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel = MainViewModel()
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            if isSearching {
                SearchView(viewModel: viewModel, isSearching: $isSearching)
                    .navigationBarHidden(true)
            } else {
                contentView
                    .navigationBarHidden(true)
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack {
            HStack {
                Text("Bitrace")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                    .foregroundStyle(.main)
                
                Spacer()
                
                Button(action: {
                    isSearching.toggle()
                }) {
                    Image(.searchIcon)
                        .resizable()
                        .foregroundStyle(.main)
                        .frame(maxWidth: 25, maxHeight: 25)
                        .padding(.trailing)
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 30)
            .padding(.top, 12)
            
            ScrollView {
                BannerView(viewModel: self.viewModel)
                    .frame(height: 200)
                    .padding(.vertical)
                    .onAppear {
                        viewModel.fetchTicker(market: "KRW-BTC")
                    }
            }
            .frame(height: 230)
            .refreshable {
                viewModel.fetchTicker(market: "KRW-BTC")
            }
            
            Text("Market")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity,
                       maxHeight: 20,
                       alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 6)
            
            ScrollView {
                MarketListView(viewModel: self.viewModel)
                    .onAppear {
                        viewModel.fetchCoinMarket()
                    }
            }
        }
        .scrollIndicators(.hidden)
    }
}


#Preview {
    MainView()
}
