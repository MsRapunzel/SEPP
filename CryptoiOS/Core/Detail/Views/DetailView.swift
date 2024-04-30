//
//  DetailView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 27.04.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    init(coin: Binding<CoinModel?>) {
        self._coin = coin
        print("Initializing Detail View for \(String(describing: coin.wrappedValue?.name))")
    }
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        Text("Hello")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View{
        DetailView(coin: dev.coin)
    }
}
