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
        
        // We are subscribing to all Coins
//        dataService.$allCoins
//            .sink { [weak self] receivedCoins in
//                self?.allCoins = receivedCoins
//            }
//            .store(in: &cancellables)
        
        // Updates all coins.
        $searchText
            .combineLatest(dataService.$allCoins)
            .map (filterCoins) // Since Map returns the string and the Coin and filterCoins takes those as the input in that order. We don't need to specify that here. We can directly call the map(filterCoins) and that translates to map { text, startingCoins -> [Coin] in filterCoins(text: self.text, startingCoins: self.startingCoins)}
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, startingCoins: [Coin]) -> [Coin] {
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
}
