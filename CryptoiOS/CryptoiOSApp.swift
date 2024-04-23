//
//  CryptoiOSApp.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 22.04.2024.
//
//asdadasd

import SwiftUI

@main
struct CryptoiOSApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
