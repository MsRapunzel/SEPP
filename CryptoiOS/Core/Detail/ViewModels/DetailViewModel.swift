//
//  DetailViewModel.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 30.04.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails

            .sink { (returnedCoinDetails) in
                print("RECEIVED COIN DETAIL DATA")
                print(returnedCoinDetails!)
            }
            .store(in: &cancellables)
        
    }
}
