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
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: sortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum sortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init(){
        addSubscribers()
    }
    
    //MARK: - Add subscribers.
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
            .combineLatest(coinDataService.$allCoins, $sortOption) // Subscribes to the sort option publisher as well
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // Essentially waits 0.5 seconds before running the next statements. It only runs if nothing new is changed for searchText or dataService.$allCoins.
            .map (filterAndSortCoins) // Since Map returns the string and the Coin and filterCoins takes those as the input in that order. We don't need to specify that here. We can directly call the map(filterCoins) and that translates to map { text, startingCoins -> [Coin] in filterCoins(text: self.text, startingCoins: self.startingCoins)}
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // This updates the portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoins(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // This Updates the market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    // MARK: - Update Portfolio
    func updatePortfolio(coin: Coin, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    // MARK: - Reload Data
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    // MARK: - Filter and Sort Coins MAP
    private func filterAndSortCoins(text: String, startingCoins: [Coin], sort: sortOption) -> [Coin] {
        var updatedCoins = filterCoins(text: text, startingCoins: startingCoins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    // MARK: - Sorting Coins
    // Here are we are inputing an array and outputing a new array. It is creating a new array and we are returning it. Since we are inputing the array of Coin and outputing the same, can sort it in the place and return the same coin model. So we are using the keyword inout. It is a tiny bit efficient than returning a new array, since we are sorting it in the place.
    private func sortCoins(sort: sortOption, coins: inout [Coin]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoins(coins: [Coin]) -> [Coin] {
        // Only sort by holdings or reversed holdings if needed.
        switch self.sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    }
    
    // MARK: - Filter Coins MAP
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
    
    // MARK: - Coins to Portfolio Coins MAP
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin]{
        allCoins
            .compactMap { coin -> Coin? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    // MARK: - Global Market Data MAP
    private func mapGlobalMarketData(marketDataModel: MarketData?, portfolioCoins: [Coin]) -> [Statistic]{
        var stats: [Statistic] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        //        let portfolioValue = portfolioCoins.map { coin -> Double in
        //            return coin.currentHoldingsValue
        //        }
        // Does the smae thing as above
        let portfolioValue = portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currenvalue = coin.currentHoldingsValue
                let percentageChange = (coin.priceChangePercentage24H ?? 0.0) / 100
                let previousValue = currenvalue / (1 + percentageChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChangePortfolio = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = Statistic(title: "Portfolio Value", value: portfolioValue.asCurrencywith2Decimals(), percentageChange: percentageChangePortfolio)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
