//
//  CircleButtonView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 23.04.2024.
//

import SwiftUI

/// A view that displays a circular button with a system icon.
struct CircleButtonView: View {
    
    /// The name of the system icon to be displayed in the button.
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(){
                Circle()
                    .foregroundStyle(Color.theme.background)
            }
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10, x: 0, y: 0)
            .padding()
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "info")
            .previewLayout(.sizeThatFits)

        CircleButtonView(iconName: "plus")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
