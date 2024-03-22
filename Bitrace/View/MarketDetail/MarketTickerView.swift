//
//  MarketTickerView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import SwiftUI

struct MarketTickerView: View {
    
    @State var market: CoinMarketModel
    @State var selectedUnit: ChartUnitDivision = .oneMinute
    @ObservedObject var ticker: MarketTickerViewModel
    @ObservedObject var chart: ChartViewModel
    @Namespace private var animation
    
    var body: some View {
        VStack {
            HStack {
                Text(market.koreanName)
                    .font(.title)
                    .bold()
                
                Text(market.market)
                    .font(.caption)
                    .bold()
                    .padding(.top)
                
                Spacer()
            }
            .frame(maxHeight: 50)
            .foregroundStyle(.main)
                        
            VStack(alignment: .leading) {
                HStack {
                    Text("고가")
                        .font(.caption)
                    Text(ticker.high)
                        .font(.caption)
                    Spacer()
                }


                HStack {
                    Text("저가")
                        .font(.caption)
                    Text(ticker.low)
                        .font(.caption)
                    Spacer()
                }
            }
            
            Divider()
            
            HStack {
                Text(ticker.currentPrice)
                    .font(.title)
                    .bold()
                    .foregroundStyle(priceColor())
                
                Spacer()

                VStack(alignment: .center) {
                    HStack {
                        Text(ticker.changePrice)
                            .font(.caption)
                            .foregroundStyle(priceColor())
                    }
                    
                    Divider()

                    HStack {
                        Text(ticker.changePercentage)
                            .font(.caption)
                            .foregroundStyle(priceColor())
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width / 3)
            }
            
            ScrollView {
                VStack {
                    animate()
                    ChartView()
                        .frame(width: .infinity, height: UIScreen.main.bounds.height * 0.3)
                        .onAppear {
                            chart.fetchCandle(item: market, unit: selectedUnit.unitRawValue)
                        }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            ticker.startSocket(market: market)
        }
        .onDisappear {
            ticker.closeWebSocket()
        }
    }
    
    private func animate() -> some View {
        HStack {
            ForEach(ChartUnitDivision.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.title3)
                        .frame(maxWidth: .infinity/5, minHeight: 30)
                        .foregroundColor(selectedUnit == item ? .black : .gray)
                    
                    if selectedUnit == item {
                        Capsule()
                            .foregroundColor(.black)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "info", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedUnit = item
                        chart.fetchCandle(item: market, unit: selectedUnit.unitRawValue)
                    }
                }
            }
        }
    }
    
    func priceColor() -> Color {
        switch ticker.change {
        case "RISE":
            return .red
        case "EVEN":
            return .black
        case "FALL":
            return .blue
        default:
            return .black
        }
    }
}


//#Preview {
//    MarketTickerView()
//}
