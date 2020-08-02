//
//  SettingsView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct SettingsView: View {
    
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        
        NavigationView {
            Form {
                List {
                    ForEach(0..<settingsViewModel.currencyList.count) { index in
                        SettingsItemView(item: self.$settingsViewModel.currencyList[index])
                    }
                }.listRowBackground(Color("ColorBackground"))
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
