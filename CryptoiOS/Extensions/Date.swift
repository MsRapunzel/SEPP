//
//  Data.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 30.04.2024.
//

import Foundation

/// Extension of `Date` that provides additional initializers and formatting functions.
extension Date {
    
    /// Initializes a `Date` from a CoinGecko-formatted string.
    ///
    /// - Parameter coinGeckoString: The date string from CoinGecko in the format "yyyy-MM-dd'T'HH:mm:ss.SSSZ".
    ///
    ///  ```
    ///  2024-03-14T07:10:36.635Z
    ///  ```
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    /// A private date formatter for short style dates.
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    /// Converts the date to a short date string.
    ///
    /// - Returns: A string representing the date in short style format.
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
