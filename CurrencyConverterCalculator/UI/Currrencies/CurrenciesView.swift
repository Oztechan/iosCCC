//
//  SettingsView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI
import Combine

struct CurrenciesView: View {
    
    @Binding var baseCurrency: CurrencyType
    
    @ObservedObject var settingsViewModel = CurrenciesViewModel()
    
    var body: some View {
        
        NavigationView {
            if settingsViewModel.state.isLoading {
                ProgressView()
            }
            Form {
                List(settingsViewModel.state.currencyList, id: \.name) { currency in
                    CurrencyItemView(item: currency, function: {
                        settingsViewModel.updateState(currency: currency)
                    })
                }
                .listRowBackground(Color("ColorBackground"))
            }.navigationBarItems(
                
                leading: Button(
                    action: {
                        self.settingsViewModel.updateAllStates(state: true)
                    },
                    label: { Text("Select All").foregroundColor(Color("ColorText")) }
                ),
                
                trailing: Button(
                    action: {
                        self.settingsViewModel.updateAllStates(state: false)
                    },
                    label: { Text("Deselect All").foregroundColor(Color("ColorText")) }
                )
                
            ).navigationBarTitle("Settings")
        }.onReceive(self.settingsViewModel.effect) { observeEffects(effect: $0)}
    }
    
    private func observeEffects(effect: CurrenciesEffect) {
        switch effect {
        case .changeBaseCurrency(let newBase): baseCurrency = newBase
        }
    }
    
}

#if DEBUG
struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        CurrenciesView(baseCurrency: .constant(CurrencyType.EUR))
        CurrenciesView(baseCurrency: .constant(CurrencyType.EUR)).preferredColorScheme(.dark)
    }
}
#endif
