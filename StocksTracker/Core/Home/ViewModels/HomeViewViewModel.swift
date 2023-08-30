//
//  HomeViewViewModel.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 21/08/23.
//

import Foundation
import Combine

class HomeViewViewModel : ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        // Updates all coins.
        $searchText
            .combineLatest(dataService.$allCoins)
            .map { (text, startingCoins) -> [Coin] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                let lowercasedText = text.lowercased()
                return startingCoins.filter { coin -> Bool in
                    return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
                }
            }
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}
