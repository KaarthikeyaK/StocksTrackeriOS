//
//  HomeView.swift
//  StocksTracker
//
//  Created by KAARTHIKEYA K on 15/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewViewModel
    
    @State private var isShowingPortfolio : Bool = false
    
    var body: some View {
        
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                homeHeaderView
                    .padding(.horizontal)
                
                columnTitles
                
                if !isShowingPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if isShowingPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            
        }
        
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
            Spacer()
            Text(isShowingPortfolio ? "Your Portfolio" : "Live Stock Prices")
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
                CoinRowView(coin: coin, isShowHoldingsColumn: false)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 4)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, isShowHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles : some View {
        HStack {
            Text("Coin")
            Spacer()
            if isShowingPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
        
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
