//
//  CoinLogoView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 28.05.2024.
//

import SwiftUI

/// A view displaying a coin's logo and symbol.
struct CoinLogoView: View {
    
    /// The coin to display.
    let coin: CoinModel
    
    /// The view for the CoinLogoView.
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

/// Preview provider for CoinLogoView.
struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)

            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
