//
//  SettingsView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        
        NavigationView {
            List($viewModel.currencyList) {
                SettingsItemView(item: $0)
            }.navigationBarItems(
                leading: Button(
                    action: { self.viewModel.activateAll(state: true) },
                    label: { Text("Select All") }
                ),
                trailing: Button(
                    action: { self.viewModel.activateAll(state: false) },
                    label: { Text("Deselect All") }
                )
            )
            .navigationBarTitle("Settings")
            
        }
    }
}

#if DEBUG
struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(MainViewModel())
    }
}
#endif
