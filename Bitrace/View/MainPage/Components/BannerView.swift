//
//  BannerView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/20/24.
//

import SwiftUI


func bannerView() -> some View {
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
            Text("텍스트텍스트")
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
