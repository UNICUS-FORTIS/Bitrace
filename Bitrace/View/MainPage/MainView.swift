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
    @State private var isFavoriteSearching = false
    @State private var isFavoriteExpended = true
    @State private var isMarketExpended = true
    
    
    var body: some View {
        NavigationView {
            if isSearching {
                
                SearchView(viewModel: viewModel, isSearching: $isSearching)
                    .navigationBarHidden(true)
                
            } else if isFavoriteSearching {
                
                BookMarkView(viewModel: viewModel, isFavoriteSearching: $isFavoriteSearching)
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
                        isFavoriteSearching.toggle()
                    }) {
                        Image(.favorite)
                            .resizable()
                            .foregroundStyle(.main)
                            .frame(maxWidth: 25, maxHeight: 25)
                    }
                    .padding(.trailing, 6)
                    
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
                .padding(.bottom, 12)
                
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
                    HStack {
                        Text("Favorite")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity,
                                   maxHeight: 20,
                                   alignment: .leading)
                        
                        Button(action: {
                            
                            isFavoriteExpended.toggle()
                            
                        }) {
                            Image(isFavoriteExpended ? .chevronDown : .chevronRight)
                                .resizable()
                                .foregroundStyle(.main)
                                .frame(width: isFavoriteExpended ? 16 : 12,
                                       height: isFavoriteExpended ? 12 : 16)
                        }
                    }
                    .padding(.horizontal)
                    
                    if viewModel.storedMarketTickers.isEmpty &&
                        !isFavoriteExpended {
                        EmptyView()
                        
                    } else if !viewModel.storedMarketTickers.isEmpty &&
                                isFavoriteExpended {
                        
                        FavoriteView(viewModel: self.viewModel)
                            .frame(height: proxy.size.height * 0.15)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                            .transition(.opacity)
                    }
                    
                    HStack {
                        Text("Market")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity,
                                   maxHeight: 20,
                                   alignment: .leading)
                        
                        Button(action: {
                            
                            isMarketExpended.toggle()
                            
                        }) {
                            Image(isMarketExpended ? .chevronDown : .chevronRight)
                                .resizable()
                                .foregroundStyle(.main)
                                .frame(width: isMarketExpended ? 16 : 12,
                                       height: isMarketExpended ? 12 : 16)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    if isMarketExpended {
                        MarketListView(viewModel: self.viewModel)
                    } else {
                        EmptyView()
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    MainView()
}

