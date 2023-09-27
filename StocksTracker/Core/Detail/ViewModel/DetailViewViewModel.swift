//
//  DetailViewViewModel.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 26/09/23.
//

import Foundation
import Combine

class DetailViewViewModel: ObservableObject {
 
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailDataService.$coinDetails
            .sink { returnedCoinDetails in
                print("Received Coin Detail data")
                print(returnedCoinDetails ?? "Default")
            }
            .store(in: &cancellables)
    }
}
