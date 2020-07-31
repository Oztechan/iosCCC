//
//  BarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct BarView: View {
    @FetchRequest(
        entity: Currency.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Currency.name, ascending: true)]
    ) var currencyList: FetchedResults<Currency>
    
    @AppStorage(UserDefaultsKeys.baseCurrency.rawValue) var baseCurrency = Currencies.NULL.stringValue
    
    @Binding var isBarDialogShown: Bool
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                List(currencyList, id: \.name) { currency in
                    
                    BarItemView(item: currency)
                        .onTapGesture {
                            baseCurrency = currency.name
                            isBarDialogShown = false
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                }.listRowBackground(Color("ColorBackground"))
                
            }.navigationBarTitle("Base Currency")
        }
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {
    static var previews: some View {
        BarView(isBarDialogShown: .constant(true))
        BarView(isBarDialogShown: .constant(true)).preferredColorScheme(.dark)
    }
}
#endif
