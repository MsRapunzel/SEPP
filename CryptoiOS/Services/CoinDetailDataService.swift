//
//  CoinDetailDataService.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 30.04.2024.
//

import Foundation
import Combine

/// Service that fetches and manages the detailed information of a specific coin from the CoinGecko API.
class CoinDetailDataService {
    
    /// Published property that contains the details of the coin.
    @Published var coinDetails: CoinDetailModel? = nil
    
    /// Cancellable object that manages the subscription to the coin detail data stream.
    var coinDetailSubscription: AnyCancellable?
    
    /// Coin for which the details are being fetched.
    let coin: CoinModel
    
    /// Initializes a new instance of `CoinDetailDataService` for a specific coin and triggers the fetching of coin details.
    ///
    /// - Parameter coin: The coin for which the details are to be fetched.
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    /// Fetches the details of the coin from the CoinGecko API and updates the `coinDetails` property.
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }

        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
    
}
