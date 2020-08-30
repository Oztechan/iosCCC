//
//  BarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct BarView: View {
    
    @ObservedObject var vm = BarViewModel()
    var baseCurrencyChange: (CurrencyType) -> Void
    var onBarClick: () -> Void
    
    var body: some View {
        
        NavigationView {
            
            if vm.state.isLoading {
                ProgressView()
            }
            
            Form {
                
                List(vm.state.currencyList, id: \.name) { currency in
                    
                    BarItemView(item: currency)
                        .onTapGesture { vm.event.selectCurrency(currency: currency) }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                }.listRowBackground(Color("ColorBackground"))
                
            }.navigationBarTitle("Base Currency")
            
        }.onReceive(vm.effect) { observeEffects(effect: $0) }
    }
    
    private func observeEffects(effect: BarEffect) {
        switch effect {
        case .changeBaseCurrency(let newBase):
            baseCurrencyChange(newBase)
        case .closeDiaog:
            onBarClick()
        }
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {    
    static var previews: some View {
        BarView(baseCurrencyChange: {_ in }, onBarClick: {})
        BarView(baseCurrencyChange: {_ in }, onBarClick: {})
            .preferredColorScheme(.dark)
    }
}
#endif
