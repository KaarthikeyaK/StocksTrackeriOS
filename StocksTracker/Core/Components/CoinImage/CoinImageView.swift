//
//  CoinImageView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 21/08/23.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewViewModel
    
    init(coin: Coin){
        _vm = StateObject(wrappedValue: CoinImageViewViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
