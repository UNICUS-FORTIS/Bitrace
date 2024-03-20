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
                .frame(height: 200)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("BitCoin")
                    .font(.headline)
                Text(String(viewModel.bitcoinTicker?.first?.tradePrice.formatted(.number) ?? 0.formatted(.number)))
                    .font(.title)
                    .bold()
            }
            .foregroundStyle(.white)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}
