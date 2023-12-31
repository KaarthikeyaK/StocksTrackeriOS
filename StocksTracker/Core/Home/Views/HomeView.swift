//
//  HomeView.swift
//  StocksTracker
//
//  Created by KAARTHIKEYA K on 15/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewViewModel
    
    @State private var isShowingPortfolio : Bool = false //Animate Right
    @State private var isShowPortfolioView: Bool = false //New Sheet
    
    @State private var selectedCoin: Coin? = nil
    @State private var isshowDetailView: Bool = false
    
    @State private var isSettingsView: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $isShowPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
                .sheet(isPresented: $isSettingsView ){
                    SettingsView()
                }
            
            VStack {
                homeHeaderView
                    .padding(.horizontal)
                
                HomeStatsView(showPortfolio: $isShowingPortfolio)
                    .environmentObject(vm)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                Group {
                    if !isShowingPortfolio {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                    
                    if isShowingPortfolio {
                        portfolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                }
                .refreshable {
                    vm.reloadData()
                }
                
                Spacer(minLength: 0)
            }
        }
        .background(
            NavigationLink(destination: DetailLoadingView(coin: $selectedCoin), isActive: $isshowDetailView, label: {
                EmptyView()
            })
        )
    }
}

extension HomeView {
    private var homeHeaderView: some View {
        HStack {
            CircleButtonView(imageName: isShowingPortfolio ? "plus" : "info")
                .animation(.none, value: isShowingPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $isShowingPortfolio)
                )
                .onTapGesture {
                    if isShowingPortfolio {
                        isShowPortfolioView.toggle()
                    } else {
                        isSettingsView.toggle()
                    }
                }
            Spacer()
            Text(isShowingPortfolio ? "Your Portfolio" : "Live Coin Prices")
                .animation(.none)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.theme.accent)
            Spacer()
            CircleButtonView(imageName: "chevron.right")
                .rotationEffect(Angle(degrees: isShowingPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isShowingPortfolio.toggle()
                    }
                }
        }
    }
    
    private var allCoinsList: some View {
        
        List {
            ForEach(vm.allCoins) { coin in
                // We can't use Navigation Link to navigate to the other screen this is due to when the app loads all the coins that are visible to the user will load their detail view the same time and this will slow down the application. The ideal would be the lazynavigationstack, but that is not yet released in the swiftUI. So we have to use a workaround such that the detail view loads only when we click on the coin.
                CoinRowView(coin: coin, isShowHoldingsColumn: false)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 4)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, isShowHoldingsColumn: true)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 4)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles : some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if isShowingPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
                
            }
            HStack {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
        
    }
}

extension HomeView {
    private func segue(coin: Coin) {
        selectedCoin = coin
        isshowDetailView.toggle()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .automatic)
            }
            .environmentObject(dev.homeVM)
            
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .automatic)
            }
            .environmentObject(dev.homeVM)
            .preferredColorScheme(.dark)
        }
    }
}
