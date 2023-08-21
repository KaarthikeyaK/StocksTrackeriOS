//
//  HomeView.swift
//  StocksTracker
//
//  Created by KAARTHIKEYA K on 15/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowingPortfolio : Bool = false
    
    var body: some View {
        
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                homeHeaderView
                    .padding(.horizontal)
                
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .automatic)
            }
            
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .automatic)
            }
            .preferredColorScheme(.dark)
        }
    }
}
