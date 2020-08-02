//
//  SettingsViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine
import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    private let coreDataRepository = CoreDataRepository.shared
//    private let userDefaultRepository = UserDefaultsRepository()
    
    @Published var currencyList = [Currency]()
    @Published var isLoading = false

    @AppStorage(UserDefaultsKeys.baseCurrency.rawValue)
    var baseCurrency: String = Currencies.NULL.stringValue
    
    var output = ""
    
    init() {
        self.initList()
    }
    
    private func initList() {
        currencyList = coreDataRepository.getAllCurrencies()
        self.isLoading = false
    }
    
    func changeAllStates(state: Bool) {
        if !state {
            baseCurrency = Currencies.NULL.stringValue
        } else {
            if baseCurrency == Currencies.NULL.stringValue {
                baseCurrency = Currencies.EUR.stringValue
            }
        }
        currencyList.forEach {
            $0.isActive = state
            coreDataRepository.updateCurrencyStateByName(name: $0.name, state: state)
        }
        let temp = currencyList
        currencyList = temp
    }
    
    func updateItem(item: Currency) {
        currencyList.filter { $0.name == item.name }.first?.isActive = !item.isActive
        coreDataRepository.updateCurrencyStateByName(name: item.name, state: !item.isActive)
    }
}
