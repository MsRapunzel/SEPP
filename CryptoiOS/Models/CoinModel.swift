//
//  CoinModel.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 23.04.2024.
//

import Foundation

// CoinGecko API info
/*
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 JSON Response:
 [
     {
         "id": "bitcoin",
         "symbol": "btc",
         "name": "Bitcoin",
         "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
         "current_price": 65911,
         "market_cap": 1299723054780,
         "market_cap_rank": 1,
         "fully_diluted_valuation": 1386257752528,
         "total_volume": 24145277178,
         "high_24h": 67208,
         "low_24h": 65777,
         "price_change_24h": -46.79865675451583,
         "price_change_percentage_24h": -0.07095,
         "market_cap_change_24h": 752825669,
         "market_cap_change_percentage_24h": 0.05796,
         "circulating_supply": 19689112.0,
         "total_supply": 21000000.0,
         "max_supply": 21000000.0,
         "ath": 73738,
         "ath_change_percentage": -10.47719,
         "ath_date": "2024-03-14T07:10:36.635Z",
         "atl": 67.81,
         "atl_change_percentage": 97250.31328,
         "atl_date": "2013-07-06T00:00:00.000Z",
         "roi": null,
         "last_updated": "2024-04-23T12:50:24.404Z",
         "sparkline_in_7d": {
             "price": [
                 63088.07438441403,
                 63005.1644696384,
                 ...
                 66265.27015271189
             ]
         },
         "price_change_percentage_24h_in_currency": -0.07095204050338023
     }
]
*/

import Foundation


/// A model representing a cryptocurrency coin, conforming to `Identifiable` and `Codable` protocols.
struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    /// Coding keys to map JSON keys to Swift properties.
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    /// Updates the holdings of the coin.
    ///
    /// - Parameter amount: The new amount of holdings.
    /// - Returns: A new instance of `CoinModel` with updated holdings.
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    /// Calculates the value of current holdings.
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    /// Retrieves the market cap rank as an integer.
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}

  /// Model that represents the sparkline data for the last 7 days.
struct SparklineIn7D: Codable {
    /// The price data points for the last 7 days.
    let price: [Double]?
}
