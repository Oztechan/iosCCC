//
//  BarViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine
import SwiftUI

final class BarViewModel: ObservableObject {
    
    private let coreDataRepository = CoreDataRepository.shared
    
    private let userDefaultRepository = UserDefaultsRepository()
    
    @Published var currencyList = [Currency]()
    @Published var isLoading = true

    @AppStorage(UserDefaultsKeys.baseCurrency.rawValue)
    var baseCurrency: String = Currencies.NULL.stringValue
    
    init() {
        initList()
    }
    
    private func initList() {
        self.currencyList = coreDataRepository.getAllCurrencies()
            .filter { currency in
                    currency.name != baseCurrency &&
                    Currencies.withLabel(currency.name) != Currencies.NULL &&
                    currency.isActive
            }
        
        self.isLoading = false
    }
}
