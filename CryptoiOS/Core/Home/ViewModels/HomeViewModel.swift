//
//  HomeViewModel.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 23.04.2024.
//

import Foundation
import Combine

/// The `HomeViewModel` class manages the state and logic for the home view.
class HomeViewModel: ObservableObject {
    
    /// An array of statistics models.
    @Published var statistics: [StatisticModel] = []
    
    /// An array of all available coin models.
    @Published var allCoins: [CoinModel] = []
    
    /// An array of coin models in the portfolio.
    @Published var portfolioCoins: [CoinModel] = []
    
    /// A boolean indicating if data is loading.
    @Published var isLoading: Bool = false
    
    /// A string used for searching coins.
    @Published var searchText: String = ""
    
    /// The current sorting option for the coin list.
    @Published var sortOption: SortOption = .rank
    
    /// Service responsible for fetching coin data.
    private let coinDataService = CoinDataService()
    
    /// Service responsible for fetching market data.
    private let marketDataService = MarketDataService()
    
    /// A set of cancellable objects for managing subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// Enum representing the sorting options for coins.
    enum SortOption {
        case rank, rankReversed, price, priceReversed
        // TODO: add `holdings` & `holdingsReversed` to the case
    }
    
    /// Initializes a new instance of `HomeViewModel` and sets up subscribers.
    init(){
        addSubscriber()
    }
    
    /// Sets up subscribers to update `allCoins` and `statistics`.
    func addSubscriber() {
        
        /// Updates `allCoins` based on search text, coin data, and sort option.
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        /// Updates `allCoins` from coin data service.
        coinDataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        /// Updates `statistics` from market data service.
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    /// Reloads data by fetching coins and market data.
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        //TODO: update market data
    }
    
    /// Filters and sorts coins based on search text and sort option.
    /// - Parameters:
    ///   - text: The search text.
    ///   - coins: The list of coins to filter and sort.
    ///   - sort: The sorting option.
    /// - Returns: A filtered and sorted list of coins.
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    /// Filters coins based on search text.
    /// - Parameters:
    ///   - text: The search text.
    ///   - coins: The list of coins to filter.
    /// - Returns: A filtered list of coins.
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                   coin.symbol.lowercased().contains(lowercasedText) ||
                   coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    /// Sorts coins based on the selected sorting option.
    /// - Parameters:
    ///   - sort: The sorting option.
    ///   - coins: The list of coins to sort.
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank:                                 // TODO: add `.holdings`
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed:                         // TODO: add `.holdingsReversed`
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    /// Maps global market data to a list of statistics models.
    /// - Parameter marketDataModel: The market data model.
    /// - Returns: A list of statistics models.
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
