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
    @ObservedObject var viewModel: MarketTickerViewModel
    @Namespace private var animation
    
    var body: some View {
        VStack {
            HStack {
                Text(market.koreanName)
                    .font(.system(size: 36))
                    .bold()
                
                Text(market.market)
                    .font(.caption)
                    .bold()
                    .padding(.top)
                
                Spacer()
                
                VStack(alignment: .center) {
                    HStack {
                        Text("고가")
                            .font(.caption)
                        Text(viewModel.high)
                            .font(.caption)
                    }
                    Divider()
                    HStack {
                        Text("저가")
                            .font(.caption)
                        Text(viewModel.low)
                            .font(.caption)
                    }
                }
            }
            .frame(maxHeight: 50)
            .foregroundStyle(.main)
            
            Divider()
            
            HStack {
                Text(viewModel.currentPrice)
                    .font(.title)
                    .bold()
                    .foregroundStyle(priceColor())
                    .frame(minWidth: UIScreen.main.bounds.width / 2)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        dimension[.leading]
                    })

                VStack(alignment: .center) {
                    HStack {
                        Text(viewModel.changePrice)
                            .font(.caption)
                            .foregroundStyle(priceColor())

                    }
                    
                    Divider()

                    HStack {
                        Text(viewModel.changePercentage)
                            .font(.caption)
                            .foregroundStyle(priceColor())
                    }
                }
            }
            
            ScrollView {
                VStack {
                    animate()
                    ChartView(unitInfo: 1)
                        .frame(width: .infinity, height: UIScreen.main.bounds.height * 0.3)
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.startSocket(market: market)
        }
        .onDisappear {
            viewModel.closeWebSocket()
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
                    }
                }
            }
        }
    }
    
    func priceColor() -> Color {
        switch viewModel.change {
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
