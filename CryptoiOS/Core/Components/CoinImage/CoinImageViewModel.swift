//
//  CoinImageViewModel.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation
import SwiftUI
import Combine

/// A view model for managing the state of a coin image.
class CoinImageViewModel: ObservableObject {
    
    /// The image of the coin.
    @Published var image: UIImage? = nil
    
    /// A boolean value indicating whether the image is loading.
    @Published var isLoading: Bool = false
    
    /// The coin model associated with this view model.
    private let coin: CoinModel
    
    /// The service responsible for fetching the coin image.
    private let dataService: CoinImageService
    
    /// A set of cancellable objects to manage the subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes a new view model with the specified coin model.
    ///
    /// - Parameter coin: The coin model.
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    /// Adds subscribers to the data service's published properties.
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
        
    }
}
