//
//  CircleButtonAnimationView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 23.04.2024.
//

import SwiftUI

/// A view that animates a circle stroke based on a binding boolean value.
struct CircleButtonAnimationView: View {
    
    /// A binding boolean value that triggers the animation.
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none, value: UUID())
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundStyle(.red)
        .frame(width: 100, height: 100)
}
