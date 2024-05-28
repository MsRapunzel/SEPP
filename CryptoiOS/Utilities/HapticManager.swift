//
//  HapticManager.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 28.05.2024.
//

import Foundation
import SwiftUI

/// Manages haptic feedback generation.
class HapticManager {
    
    /// Haptic feedback generator instance.
    static private let generator = UINotificationFeedbackGenerator()
    
    /// Triggers a notification haptic feedback.
    /// - Parameter type: The type of feedback.
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
