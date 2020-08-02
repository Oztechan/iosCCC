//
//  BarViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine

final class BarViewModel: ObservableObject {
    
    private let coreDataRepository = CoreDataRepository.shared
    private let userDefaultRepository = UserDefaultsRepository.shared
    
    @Published var currencyList = [Currency]()
    @Published var isLoading = true
    @Published var baseCurrency: Currencies {
        didSet {
            userDefaultRepository.setBaseCurrency(value: baseCurrency)
        }
    }
    
    init() {
        baseCurrency = userDefaultRepository.getBaseCurrency()
        initList()
    }
    
    private func initList() {
        self.currencyList = coreDataRepository.getAllCurrencies()
            .filter { currency in
                currency.value != "0.0" &&
                    currency.value != "0" &&
                    currency.name != baseCurrency.stringValue &&
                    Currencies.withLabel(currency.name) != Currencies.NULL &&
                    currency.isActive
            }
        
        self.isLoading = false
    }
}
