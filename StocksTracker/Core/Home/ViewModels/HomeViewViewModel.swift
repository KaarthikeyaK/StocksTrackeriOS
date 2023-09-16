//
//  HomeViewViewModel.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 21/08/23.
//

import Foundation
import Combine

class HomeViewViewModel : ObservableObject {
    
    @Published var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value", percentageChange: -1)
    ]

    
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
        
        // Anytime searchText or dataService.allCoins are changed this subscriber publishes automatically.
        // Updates all coins.
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // Essentially waits 0.5 seconds before running the next statements. It only runs if nothing new is changed for searchText or dataService.$allCoins.
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
