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
    var baseCurrencyChangeEvent: (CurrencyType) -> Void
    @Binding var isBarShown: Bool

    var body: some View {
        
        NavigationView {
            
            if vm.state.isLoading {
                ProgressView()
            }
            
            Form {
                
                List(vm.state.currencyList, id: \.name) { currency in
                    
                    BarItemView(item: currency)
                        .onTapGesture { vm.event.selectCurrencyEvent(currency: currency) }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                }.listRowBackground(Color("ColorBackground"))
                
            }.navigationBarTitle("Base Currency")
            
        }.onReceive(vm.effect) { observeEffects(effect: $0) }
    }
    
    private func observeEffects(effect: BarEffect) {
        switch effect {
        case .changeBaseCurrencyEffect(let newBase):
            baseCurrencyChangeEvent(newBase)
        case .closeDiaogEffect:
            isBarShown = false
        }
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {    
    static var previews: some View {
        BarView(baseCurrencyChangeEvent: {_ in }, isBarShown: .constant(true)).makeForPreviewProvider()
    }
}
#endif
