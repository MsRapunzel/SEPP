//
//  UIAplication.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation
import SwiftUI

/// Extension of `UIApplication` that provides a method to dismiss the keyboard.
extension UIApplication {
    
    /// Ends editing by dismissing the keyboard.
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
