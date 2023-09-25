//
//  HomeViewViewModel.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 21/08/23.
//

import Foundation
import Combine

class HomeViewViewModel : ObservableObject {
    
    @Published var statistics: [Statistic] = []
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // Essentially waits 0.5 seconds before running the next statements. It only runs if nothing new is changed for searchText or dataService.$allCoins.
            .map (filterCoins) // Since Map returns the string and the Coin and filterCoins takes those as the input in that order. We don't need to specify that here. We can directly call the map(filterCoins) and that translates to map { text, startingCoins -> [Coin] in filterCoins(text: self.text, startingCoins: self.startingCoins)}
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // This Updates the market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
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
    
    private func mapGlobalMarketData(marketDataModel: MarketData?) -> [Statistic]{
        var stats: [Statistic] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value", value: "0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
