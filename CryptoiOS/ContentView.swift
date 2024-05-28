//
//  ContentView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 22.04.2024.
//

import SwiftUI

/// View that displays the app color scheme.
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 40){
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accent)
                Text("Secondary Text Color")
                    .foregroundStyle(Color.theme.secondaryText)
                Text("Red Color")
                    .foregroundStyle(Color.theme.red)
                Text("Green Color")
                    .foregroundStyle(Color.theme.green)
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
