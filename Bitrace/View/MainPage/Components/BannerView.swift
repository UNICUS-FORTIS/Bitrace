//
//  BannerView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI

struct BannerView : View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.coinList)
                .overlay {
                    Circle()
                        .fill(.main)
                        .offset(x: -90, y: -20)
                        .scaleEffect(1.5, anchor: .topLeading)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(maxWidth: .infinity)
                .frame(height: 180)
            
            VStack(alignment: .leading) {
                
                Text("BitCoin")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                
                HStack {
                    Text("고가")
                        .font(.caption)
                    Text(String(viewModel.bitcoinTicker?.highPrice.formatted(.number) ??
                                0.formatted(.number)))
                    .font(.caption)
                }
                .foregroundStyle(.white)

                HStack {
                    Text("저가")
                        .font(.caption)
                    Text(String(viewModel.bitcoinTicker?.lowPrice.formatted(.number) ??
                                0.formatted(.number)))
                    .font(.caption)
                }
                .padding(.bottom, 6)
                .foregroundStyle(.white)

                Spacer()

                HStack(spacing: 12) {
                    Text(String(viewModel.bitcoinTicker?.tradePrice.formatted(.number) ?? 0.formatted(.number)))
                        .font(.title)
                        .bold()
                        .foregroundStyle(viewModel.makePriceColor(change: viewModel.bitcoinTicker?.change ?? ""))


                    viewModel.makeTickerStatusIcon(change: viewModel.bitcoinTicker?.change ?? "")
                        .resizable()
                        .frame(width: 16, height: 10)
                        .foregroundStyle(viewModel.makePriceColor(change: viewModel.bitcoinTicker?.change ?? ""))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
    
    
    

}
