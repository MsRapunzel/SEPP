//
//  StatisticModel.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation

/// Model that represents a statistic with an identifier.
struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    /// Initializes a new statistic model.
    ///
    /// - Parameters:
    ///   - title: The title of the statistic.
    ///   - value: The value of the statistic.
    ///   - percentageChange: The percentage change (optional).
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
