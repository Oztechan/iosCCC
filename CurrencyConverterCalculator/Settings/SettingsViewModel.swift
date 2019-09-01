//
//  SettingsViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 25/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    
    @Published var currencyList = [Currency]()
    var baseCurrency = Currencies.EUR {
        didSet {
            UserDefaults.standard.setBaseCurrency(value: baseCurrency)
        }
    }
    
    init() {
        baseCurrency = UserDefaults.standard.getBaseCurrency()
    }
    
    func initList() {
        CoreDataManager.shared.getAllCurrencies().forEach { currency in
            if Currencies.withLabel(currency.name) != Currencies.NULL {
                self.currencyList.append(currency)
            }
        }
    }
    
    func changeAllStates(state: Bool) {
        if !state {
            baseCurrency = Currencies.NULL
        } else {
            if baseCurrency == Currencies.NULL {
                baseCurrency = Currencies.EUR
            }
        }
        currencyList.forEach {
            $0.isActive = state
            CoreDataManager.shared.updateCurrencyStateByName(name: $0.name, state: state)
        }
        let temp = currencyList
        currencyList = temp
    }
    
    func updateItem(item: Currency) {
        currencyList.filter { $0.name == item.name }.first?.isActive = item.isActive
    }
}
