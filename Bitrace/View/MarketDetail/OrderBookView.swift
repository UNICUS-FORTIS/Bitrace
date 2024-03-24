//
//  OrderBookView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import SwiftUI

struct OrderBookView: View {
    
    @ObservedObject private var viewModel = OrderBookViewModel.shared
    @Binding var selectedOrder: OrderBookDivision
    
    var body: some View {
        GeometryReader { proxy in
            let graphWidth = proxy.size.width * 0.7
                LazyVStack {
                    ForEach(assignOrderBook(), id: \.id) { item in
                        HStack {
                            Text(item.price.formatted())
                                .font(.caption)
                                .frame(width: proxy.size.width * 0.3)
                                .foregroundStyle(makeChartColor())
                                .bold()
                            
                            ZStack(alignment: .leading) {
                                
                                let graphSize = makeBidSize(item: item,
                                                            graphWidth: graphWidth)
                                
                                Rectangle()
                                    .foregroundStyle(makeChartColor())
                                    .frame(maxWidth: graphSize,
                                           alignment: .leading)
                                
                                Text(item.size.formatted(.number.precision(.fractionLength(3))))
                                    .font(.caption)
                                    .frame(width: graphWidth)
                            }
                            .frame(maxWidth: .infinity)
                            .background(makeChartColor().opacity(0.4))
                        }
                        .frame(height: 30)
                    }
                }
        }
    }
    
    func assignOrderBook() -> [OrderbookItem] {
        if selectedOrder == .ask {
            return viewModel.askOrderBook
        } else {
            return viewModel.bidOrderBook
        }
    }
    
    func makeChartColor() -> Color {
        if selectedOrder == .ask {
            return .blue
        } else {
            return .red
        }
    }
    
    func makeBidSize(item: OrderbookItem, graphWidth: CGFloat) -> CGFloat {
        
        if selectedOrder == .ask {
            return item.size / viewModel.largestAskSize() * graphWidth
        } else {
            return item.size / viewModel.largestBidSize() * graphWidth
        }
    }
}
//
//#Preview {
//    OrderBookView(market: )
//}
