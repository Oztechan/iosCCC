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
    @Binding var isBarDialogShown: Bool
    @Binding var baseCurrency: CurrencyType
    
    var body: some View {
        
        NavigationView {
            if vm.state.isLoading {
                ProgressView()
            }
            Form {
                List(self.vm.state.currencyList, id: \.name) { currency in
                    
                    BarItemView(item: currency)
                        .onTapGesture { vm.event.selectCurrency(currency: currency) }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                }.listRowBackground(Color("ColorBackground"))
            }.navigationBarTitle("Base Currency")
        }.onReceive(self.vm.effect) { observeEffects(effect: $0) }
    }
    
    private func observeEffects(effect: BarEffect) {
        switch effect {
        case .changeBaseCurrency(let newBase):
            baseCurrency = newBase
        case .closeDiaog:
            isBarDialogShown = false
        }
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {    
    static var previews: some View {
        BarView(
            isBarDialogShown: .constant(true),
            baseCurrency: .constant(CurrencyType.EUR)
        )
        BarView(
            isBarDialogShown: .constant(true),
            baseCurrency: .constant(CurrencyType.EUR)
        ).preferredColorScheme(.dark)
    }
}
#endif
