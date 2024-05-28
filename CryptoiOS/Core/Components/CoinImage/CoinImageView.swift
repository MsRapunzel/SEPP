//
//  CoinImageView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import SwiftUI

/// A view that displays a coin image or a loading indicator.
struct CoinImageView: View {
    
    /// The view model managing the coin image state.
    @StateObject var vm: CoinImageViewModel
    
    /// Initializes a new view with the specified coin model.
    ///
    /// - Parameter coin: The coin model.
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider  {
    static var previews: some View{
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
