//
//  StocksTrackerApp.swift
//  StocksTracker
//
//  Created by KAARTHIKEYA K on 15/08/23.
//

import SwiftUI

@main
struct PaperCoinApp: App {
    
    @StateObject private var vm = HomeViewViewModel()
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .automatic)
            }
            .environmentObject(vm)
        }
    }
}
