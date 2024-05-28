//
//  CoinImageService.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation
import SwiftUI
import Combine

/// Service that fetches and manages the image of a specific coin from the CoinGecko API.
class CoinImageService {
    
    /// Published property that contains the image of the coin.
    @Published var image: UIImage? = nil
    
    /// Cancellable object that manages the subscription to the image data stream.
    private var imageSubscription: AnyCancellable?
    
    /// Coin for which the image is being fetched.
    private let coin: CoinModel
    
    /// Instance of `LocalFileManager` for saving and retrieving images locally.
    private let fileManager = LocalFileManager.instance
    
    /// Name of the folder where the coin images are stored.
    private let folderName = "coin_images"
    
    /// Name of the image file for the coin.
    private let imageName: String
    
    /// Initializes a new instance of `CoinImageService` for a specific coin and triggers the fetching of the coin image.
    ///
    /// - Parameter coin: The coin for which the image is to be fetched.
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    /// Retrieves the coin image from the local storage or triggers the download if not available locally.
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    /// Downloads the coin image from the CoinGecko API and saves it locally.
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}
