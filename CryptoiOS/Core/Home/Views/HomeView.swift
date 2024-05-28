//
//  HomeView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 23.04.2024.
//

import SwiftUI

/// The main view for the home screen.
struct HomeView: View {
    
    /// The view model for the home screen.
    @EnvironmentObject private var vm: HomeViewModel
    
    /// A state variable indicating whether the portfolio should be shown.
    @State private var showPortfolio: Bool = false
    
    /// A state variable for the selected coin.
    @State private var selectedCoin: CoinModel? = nil
    
    /// A state variable indicating whether the detail view should be shown.
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            
            //background layer
            Color.theme.background
                .ignoresSafeArea ()
            
            // content layer
            VStack {
                
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                //TODO: if showPortfolio
                
                Spacer(minLength: 0)
                
            }
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: { EmptyView() })
        )
    }
}

struct HomeView_Previews: PreviewProvider  {
    static var previews: some View{
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    
    /// A view for header section of the home view.
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: UUID())
                .background(){
                    CircleButtonAnimationView(animate: $showPortfolio)
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    /// A view for list of all coins.
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 15))
                    .listRowBackground(Color.theme.background)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    /// Segue to the detail view for a selected coin.
    /// - Parameter coin: The coin model to be passed to the detail view.
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    //TODO: Setup the portfolio
    
    /// The column titles section of the home view.
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            // TODO: if showPortfolio
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
