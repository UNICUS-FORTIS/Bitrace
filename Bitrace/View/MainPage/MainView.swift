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
                    .onAppear {
                        viewModel.fetchStoredMarketTickers()
                    }
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        GeometryReader { proxy in
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
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                        .onAppear {
                            viewModel.fetchTicker(market: "KRW-BTC")
                        }
                }
                .frame(height: 200)
                .refreshable {
                    viewModel.fetchTicker(market: "KRW-BTC")
                }
                
                ScrollView(.vertical) {
                    Text("Favorite")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity,
                               maxHeight: 20,
                               alignment: .leading)
                        .padding(.leading)
                    
                    if viewModel.storedMarketTickers.isEmpty {
                        EmptyView()
                    } else {
                        FavoriteView(viewModel: self.viewModel)
                            .frame(height: proxy.size.height * 0.15)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                    }
                    
                    Text("Market")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity,
                               maxHeight: 20,
                               alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, 6)
                    
                    MarketListView(viewModel: self.viewModel)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    MainView()
}

