//
//  SettingsView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CurrenciesView: View, Effect {
    
    func asd(newBase: CurrencyType) {
        baseCurrency = newBase
    }
    
    @Binding var baseCurrency: CurrencyType
    
    @ObservedObject var settingsViewModel = CurrenciesViewModel()
    
    var body: some View {
        
        NavigationView {
            Form {
                List(settingsViewModel.currencyList, id: \.name) { currency in
                    CurrencyItemView(item: currency, function: {
                        settingsViewModel.updateItem(item: currency)
                    })
                }
                .listRowBackground(Color("ColorBackground"))
            }.navigationBarItems(
                
                leading: Button(
                    action: {
                        self.baseCurrency = self.settingsViewModel.changeAllStates(
                            state: true,
                            baseCurrency: baseCurrency
                        )
                    },
                    label: { Text("Select All").foregroundColor(Color("ColorText")) }
                ),
                
                trailing: Button(
                    action: {
                        self.baseCurrency = self.settingsViewModel.changeAllStates(
                            state: false,
                            baseCurrency: baseCurrency
                        )
                    },
                    label: { Text("Deselect All").foregroundColor(Color("ColorText")) }
                )
                
            ).navigationBarTitle("Settings")
        }
    }
}

protocol Effect {

    func asd(newBase: CurrencyType)
}

#if DEBUG
struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        CurrenciesView(baseCurrency: .constant(CurrencyType.EUR))
        CurrenciesView(baseCurrency: .constant(CurrencyType.EUR)).preferredColorScheme(.dark)
    }
}
#endif
