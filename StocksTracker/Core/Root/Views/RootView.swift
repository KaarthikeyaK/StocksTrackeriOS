//
//  RootView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 28/09/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Coins", systemImage: "bitcoinsign.circle.fill")
                }
            StockHomeView()
                .tabItem {
                    Label("Stocks", systemImage: "banknote.fill")
                }
        }
    }
}
