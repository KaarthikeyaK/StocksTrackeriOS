//
//  CoinRowView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 21/08/23.
//

import SwiftUI

struct CoinRowView: View {

    let coin: Coin
    let isShowHoldingsColumn: Bool
    
    var body: some View {
        HStack (spacing: 0){
            
            leftColumn
            
            Spacer()
            
            if isShowHoldingsColumn {
                centerColumn
            }
        
            rightColumn
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.subheadline)
    }
}

extension CoinRowView {
    //MARK: - Left Column View
    private var leftColumn: some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }
    }
    
    //MARK: - Center Column
    private var centerColumn: some View {
            VStack (alignment: .trailing) {
                Text(coin.currentHoldingsValue.asCurrencywith2Decimals())
                    .bold()
                Text((coin.currentHoldings ?? 0).asNumberString())
            }
            .foregroundColor(.theme.accent)
    }
    
    //MARK: - Right Column
    private var rightColumn: some View {
        VStack (alignment: .trailing){
            Text(coin.currentPrice.asCurrencywith6Decimals())
                .bold()
                .foregroundColor(.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, isShowHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, isShowHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
