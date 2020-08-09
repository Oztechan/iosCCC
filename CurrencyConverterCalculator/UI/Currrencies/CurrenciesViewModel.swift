//
//  SettingsViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine

final class CurrenciesViewModel: ObservableObject {
    
    private let coreDataRepository = CoreDataRepository.shared
    
    @Published var currencyList = [Currency]()
    @Published var isLoading = false
    
    var output = ""
    
    init() {
        self.initList()
    }
    
    private func initList() {
        currencyList = coreDataRepository.getAllCurrencies()
        self.isLoading = false
    }
    
    func changeAllStates(state: Bool, baseCurrency: CurrencyType) -> CurrencyType {
        
        currencyList.forEach {
            $0.isActive = state
            coreDataRepository.updateCurrencyStateByName(name: $0.name, state: state)
        }
        let temp = currencyList
        currencyList = temp
        
        if !state {
            return CurrencyType.NULL
        } else {
            if baseCurrency == CurrencyType.NULL {
                return getFirstAvaiableBaseCurrencyOrNull()
            } else {
                return baseCurrency
            }
        }
    }
    
    func updateItem(item: Currency, baseCurrency: CurrencyType) -> CurrencyType {
        currencyList.filter { $0.name == item.name }.first?.isActive = !item.isActive
        coreDataRepository.updateCurrencyStateByName(name: item.name, state: !item.isActive)
        
        if CurrencyType.withLabel(item.name) == baseCurrency || baseCurrency == CurrencyType.NULL {
            return getFirstAvaiableBaseCurrencyOrNull()
        } else {
            return baseCurrency
        }
    }
    
    func getFirstAvaiableBaseCurrencyOrNull() -> CurrencyType {
        return CurrencyType.withLabel(
            currencyList.filter { $0.isActive == true }.first?.name
        )
    }
}
