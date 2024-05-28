//
//  String.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 30.04.2024.
//

import Foundation

/// An extension of `String` that provides a method to remove HTML tags.
extension String {
    
    /// Removes HTML occurrences from the string.
    ///
    /// - Returns: A new string with HTML tags removed.
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
