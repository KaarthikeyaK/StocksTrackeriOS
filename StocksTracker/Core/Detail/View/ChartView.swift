//
//  ChartView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 27/09/23.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    
    private let maxY: Double
    private let minY: Double
    
    private let lineColor: Color
    
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 1.0
    
    init(coin: Coin){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    // If I have a screen of width 300 points and we have 100 points
    // Each xPosition is of 3 points
    
    var body: some View {
        
        // We are gonna draw a line that uses x and y axis.
        // It's kind of a chart but it is flipped upside down.
        // The data we are putting is sparkline7D
        // It is a price array which is array of double.
        
        // We need to create our chart to dynamic such that every chart has different y axis
        
        // The co-ordinate system on the iphone is reversed. So we have to reverse the graph after we have get the points.
        
        VStack {
            chartView
                .frame(height: 200)
                .background(
                    chartBackground
                )
                .overlay(
                    chartYAxis.padding(.horizontal, 4),
                    alignment: .leading
                )
            
            chartDatelabels
                .padding(.horizontal, 4)
            
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    // Suppose maxY is 60,000 and minY is 50,000
                    // yAxis is 10,0000
                    // Suppose the datapoint is 52,000
                    // 52,000 - 50,000 = 2000 / 10000 = 20%
                    // The dataPoint must be 20% below the screen.
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trimmedPath(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
            
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreavations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreavations())
            Spacer()
            Text(minY.formattedWithAbbreavations())
        }
    }
    
    private var chartDatelabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
