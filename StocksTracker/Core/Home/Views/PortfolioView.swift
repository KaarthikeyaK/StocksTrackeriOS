//
//  PortfolioView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 16/09/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm : HomeViewViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoListView
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { oldValue, _ in
                if oldValue == " " {
                    removeSelectedCoin()
                }
            }
        }
    }
}

extension PortfolioView {
    private var coinLogoListView: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            // Lazy creates the items only that are needed and not excess before hand. This is a good practice increasing the speed of the application.
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) {coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear
                                        , lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
        
    private func updateSelectedCoin(coin: Coin){
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}), let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencywith2Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex. 1.5", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencywith2Decimals())
            }
        }
        .animation(.none, value: quantityText)
        .padding()
        .font(.headline)

    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
            }
        }
        .font(.headline)

    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    private func saveButtonPressed() {
        
        guard let coin = selectedCoin ,
        let amount = Double(quantityText)
        else { return }
        
        // Save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        // show the checkmark
        withAnimation(.easeIn){
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide the keyboard
        UIApplication.shared.endEditing()
        
        //Hide checimark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        withAnimation {
            selectedCoin = nil
            vm.searchText = ""
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
