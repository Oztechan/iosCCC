//
//  SettingsView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Currency.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Currency.name, ascending: true)]
    ) var currencyList: FetchedResults<Currency>
    
    @AppStorage(UserDefaultsKeys.baseCurrency.rawValue) var baseCurrency = Currencies.NULL.stringValue
    
    var body: some View {
        
        NavigationView {
            Form {
                List(currencyList, id: \.name) { currency in
                    SettingsItemView(item: currency)
                }.listRowBackground(Color("ColorBackground"))
            }.navigationBarItems(
                
                leading: Button(
                    action: { changeAllStates(state: true) },
                    label: { Text("Select All").foregroundColor(Color("ColorText")) }
                ),
                
                trailing: Button(
                    action: { changeAllStates(state: false) },
                    label: { Text("Deselect All").foregroundColor(Color("ColorText")) }
                )
                
            ).navigationBarTitle("Settings")
        }
    }
    
    func changeAllStates(state: Bool) {
        if !state {
            baseCurrency = Currencies.NULL.stringValue
        } else {
            if baseCurrency == Currencies.NULL.stringValue {
                baseCurrency = Currencies.EUR.stringValue
            }
        }
        
        currencyList.forEach { item in
            item.isActive = state
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
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
