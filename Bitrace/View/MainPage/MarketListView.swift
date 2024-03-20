//
//  MarketListView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI


struct MarketListView: View {
    
    @StateObject private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        LazyVStack(spacing: 10) {
            ForEach(viewModel.coinMarketArray, id: \.self) { item in
                NavigationLink(destination: DetailView(coinMarketModel: item)) {
                    ZStack {
                        Rectangle()
                            .fill(.coinList)
                            .frame(height: UIScreen.main.bounds.height * 0.1)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text(item.koreanName)
                                .fontWeight(.bold)
                                .foregroundStyle(.main)
                                .padding(.leading)
                            Spacer()
                            Text(item.englishName)
                                .font(.caption)
                                .foregroundStyle(.main)
                                .padding(.trailing)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

