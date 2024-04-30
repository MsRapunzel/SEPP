//
//  String.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 30.04.2024.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
