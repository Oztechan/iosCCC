//
//  BarViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine
import SwiftUI

extension BarView {
    
    final class BarViewModel: ObservableObject {
        
        @Environment(\.managedObjectContext) var managedObjectContext
        
        @FetchRequest(
            entity: Currency.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Currency.name, ascending: true)],
            predicate: NSPredicate(format: "currency.isActive == %@", true),
            animation: .default
        ) var currencyList: FetchedResults<Currency>
        
        @AppStorage(UserDefaultsKeys.baseCurrency.rawValue) var baseCurrency = Currencies.NULL.stringValue
        
        @Binding var isBarDialogShown: Bool?
    
        init() {
            
        }
        
    }
}
