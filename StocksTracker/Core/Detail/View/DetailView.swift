//
//  DetailView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 26/09/23.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }

}

struct DetailView: View {
    
    @StateObject var vm: DetailViewViewModel
    let coin: Coin
    
    init(coin: Coin){
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewViewModel(coin: coin))
    }
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
