//
//  Color.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 22.04.2024.
//

import Foundation
import SwiftUI

/// An extension of the `Color` class that provides a static theme property.
extension Color {
    
    /// Provides a centralized color theme for the application.
    static let theme = ColorTheme()
}

/// A struct that defines a theme with a set of predefined colors.
struct ColorTheme {
    
    /// The accent color used throughout the app.
    let accent = Color("AccentColor")
    
    /// The background color used throughout the app.
    let background = Color("BackgroundColor")
    
    /// A green color to emphasize positive trends.
    let green = Color("GreenColor")
    
    /// A red color to emphasize positive trends negative trends.
    let red = Color("RedColor")
    
    /// A secondary text color for less prominent text elements.
    let secondaryText = Color("SecondaryTextColor")
}
