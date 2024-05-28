//
//  HomeStatsView.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import SwiftUI

/// A view representing the home statistics section.
struct HomeStatsView: View {
    
    /// The view model for the home screen.
    @EnvironmentObject private var vm: HomeViewModel
    
    /// A binding indicating whether the portfolio should be shown.
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading
        )
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
