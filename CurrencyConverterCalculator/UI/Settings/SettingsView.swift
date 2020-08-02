//
//  SettingsView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        
        NavigationView {
            Form {
                List(settingsViewModel.currencyList, id: \.name) { currency in
                    SettingsItemView(item: currency, function: {
                        settingsViewModel.updateItem(item: currency)
                    })
                }
                .listRowBackground(Color("ColorBackground"))
            }.navigationBarItems(
                
                leading: Button(
                    action: { self.settingsViewModel.changeAllStates(state: true) },
                    label: { Text("Select All").foregroundColor(Color("ColorText")) }
                ),
                
                trailing: Button(
                    action: { self.settingsViewModel.changeAllStates(state: false) },
                    label: { Text("Deselect All").foregroundColor(Color("ColorText")) }
                )
                
            ).navigationBarTitle("Settings")
        }
    }
}

#if DEBUG
struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        SettingsView().preferredColorScheme(.dark)
    }
}
#endif
