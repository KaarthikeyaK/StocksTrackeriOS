//
//  SettingsView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 28/09/23.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let githubURL = URL(string: "https://github.com/KaarthikeyaK")!
    
    var body: some View {
        NavigationStack {
            List {
//                personalSection
                
                coinGeckoSection
                
                developerSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

extension SettingsView {
    private var personalSection: some View {
        Section {
            VStack(alignment: .leading, content: {
                Image("logo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made with Combine, Core Data and MVVM Architecture")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding(.vertical)
        } header: {
            Text("Kaarthikeya Kammula")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading, content: {
                Image("coingecko")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this appc omes from a free API from CoinGecko. Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding(.vertical)
            
            Link("View CoinGecko", destination: coingeckoURL)
                .tint(Color.blue)
        } header: {
            Text("Coin-Gecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading, content: {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by Kaarthikeya Kammula by following Nick Sarno from Swiftful thinking. This is written completely in Swift. This project benefits from multi - threading, publishers / subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding(.vertical)
            
            Link("View my github", destination: githubURL)
                .tint(Color.blue)
        } header: {
            Text("Developer")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
