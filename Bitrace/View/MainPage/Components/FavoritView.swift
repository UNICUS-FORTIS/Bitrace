//
//  FavoriteView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/24/24.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject var viewModel: MainViewModel
    @StateObject var marketViewModel = MarketTickerViewModel.shared
    @StateObject var chartViewModel = ChartViewModel.shared
    @StateObject var orderBookViewModel = OrderBookViewModel.shared
    
    var body: some View {
        
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(viewModel.storedMarketTickers, id: \.market) { item in
                        if let market = viewModel.findMarketLink(market: item.market) {
                            NavigationLink(destination:
                                            MarketTickerView(market: market,
                                                             ticker: marketViewModel,
                                                             chart: chartViewModel,
                                                             order: orderBookViewModel)) {
                                
                                storedMarketView(item: market, ticker: item)
                                    .frame(width: proxy.size.width * 0.4,
                                           height: proxy.size.height)
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func storedMarketView(item: CoinMarketModel, ticker: TickerResponse) -> some View {
        ZStack {
            Rectangle()
                .fill(.main)
                .frame(height: UIScreen.main.bounds.height * 0.1)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack {
                VStack(alignment: .leading) {
                    Text(item.koreanName)
                        .foregroundStyle(.white)
                        .bold()
                    HStack {
                        Text(String(ticker.tradePrice.formatted(.number)))
                            .bold()
                            .foregroundStyle(viewModel.makePriceColor(change: ticker.change))
                        
                        viewModel.makeTickerStatusIcon(change: ticker.change)
                            .resizable()
                            .frame(width: 10, height: 8)
                            .foregroundStyle(viewModel.makePriceColor(change: ticker.change))
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

//#Preview {
//    FavoritView()
//}
