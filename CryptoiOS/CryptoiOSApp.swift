//
//  CryptoiOSApp.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 22.04.2024.
//

import SwiftUI

@main
struct CryptoiOSApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
