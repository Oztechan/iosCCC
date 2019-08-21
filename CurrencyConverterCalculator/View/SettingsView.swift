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
        
        VStack {
            
            HStack {
                
                Spacer()
                
                Button(
                    action: { self.viewModel.changeAllStates(state: true) },
                    label: { Text("Select All") }
                )
                
                Button(
                    action: { self.viewModel.changeAllStates(state: false) },
                    label: { Text("Deselect All") }
                )
                
            }
            
            List(viewModel.currencyList) {
                SettingsItemView(item: $0)
            }
        }.padding()
    }
}

#if DEBUG
struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(MainViewModel())
    }
}
#endif
