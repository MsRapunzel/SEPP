//
//  CoinDataService.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 23.04.2024.
//

import Foundation
import Combine

/// Service that fetches and manages the list of all coins from the CoinGecko API.
class CoinDataService {
    
    /// A published property that contains the list of all coins.
    @Published var allCoins: [CoinModel] = []
    
    /// A cancellable object that manages the subscription to the coin data stream.
    var coinSubscription: AnyCancellable?
    
    /// Initializes a new instance of `CoinDataService` and triggers the fetching of coin data.
    init() {
        getCoins()
    }
    
    /// Fetches the list of all coins from the CoinGecko API and updates the `allCoins` property.
    public func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=uah&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
        
    }
    
}
