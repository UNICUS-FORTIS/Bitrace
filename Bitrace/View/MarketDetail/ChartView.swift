//
//  ChartView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/21/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @ObservedObject var chart = ChartViewModel.shared
    
    var body: some View {
        VStack {
            Chart {
                ForEach(chart.candleData, id: \.id) { item in
                    RectangleMark(x: .value("time", item.time),
                                  yStart: .value("Low", item.low),
                                  yEnd: .value("High", item.high),
                                  width: 2)
                    .foregroundStyle(candleColor(item: item))
                    
                    RectangleMark(x: .value("time", item.time),
                                  yStart: .value("openPrice", item.openPrice),
                                  yEnd: .value("tradePrice", item.tradePrice),
                                  width: 6)
                    .foregroundStyle(candleColor(item: item))
                }
            }
            .chartYScale(domain: chart.findMinMaxValues() ?? 0...10)
            .chartXAxis {
                AxisMarks(stroke: StrokeStyle(lineWidth: 0))
            }
            .chartScrollableAxes(.horizontal)
        }
        .padding(.top, 6)
        .frame(maxWidth: .infinity)
    }
    
    func candleColor(item: CandleModel) -> Color{
        item.openPrice > item.tradePrice ? .blue : .red
    }
}
