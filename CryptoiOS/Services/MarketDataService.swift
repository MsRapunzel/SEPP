//
//  MarketDataService.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation
import Combine

/// Service that fetches and manages the market data from the CoinGecko API.
class MarketDataService {
    
    /// Published property that contains the market data.
    @Published var marketData: MarketDataModel? = nil
    
    /// Cancellable object that manages the subscription to the market data stream.
    var marketDataSubscription: AnyCancellable?
    
    /// Initializes a new instance of `MarketDataService` and triggers the fetching of market data.
    init() {
        getData()
    }
    
    /// Fetches the global market data from the CoinGecko API and updates the `marketData` property.
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
    
}
