//
//  SettingsViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine

final class CurrenciesViewModel: ObservableObject, CurrenciesEvent {
    
    // MARK: SEED
    @Published
    private(set) var state = CurrenciesState()
    let effect = PassthroughSubject<CurrenciesEffect, Never>()
    private(set) lazy var event = self as CurrenciesEvent
    private(set) var data = CurrenciesData()
    
    init() {
        self.initList()
    }
    
    private func initList() {
        state.currencyList = data.coreDataRepository.getAllCurrencies()
        state.isLoading = false
    }
    
    private func getFirstAvaiableBaseCurrencyOrNull() -> CurrencyType {
        return CurrencyType.withLabel(
            self.state.currencyList.filter { $0.isActive == true }.first?.name
        )
    }
    
    private func setBaseCurrency(newBase: CurrencyType) {
        data.baseCurrency = newBase
        effect.send(CurrenciesEffect.baseCurrencyChangeEffect(newBase))
    }
    
    // MARK: Event
    func updateAllEvent(state: Bool) {
        
        self.state.currencyList.forEach {
            $0.isActive = state
            data.coreDataRepository.updateCurrencyStateByName(name: $0.name, state: state)
        }
        let temp = self.state.currencyList
        self.state.currencyList = temp
        
        if !state {
            setBaseCurrency(newBase: CurrencyType.NULL)
        } else {
            if data.baseCurrency == CurrencyType.NULL {
                setBaseCurrency(newBase: getFirstAvaiableBaseCurrencyOrNull())
            }
        }
    }
    
    func updateCurrencyEvent(currency: Currency) {
        state.currencyList.filter { $0.name == currency.name }.first?.isActive = !currency.isActive
        data.coreDataRepository.updateCurrencyStateByName(name: currency.name, state: !currency.isActive)
        
        if currency.name == data.baseCurrency.stringValue
            || data.baseCurrency == CurrencyType.NULL {
            setBaseCurrency(newBase: getFirstAvaiableBaseCurrencyOrNull())
        }
    }
    
    func doneClickEvent() {
        if state.currencyList.filter({ $0.isActive == true }).count >= 2 {
            data.firstRun = false
            effect.send(CurrenciesEffect.appInitialiseEffect)
        } else {
            effect.send(CurrenciesEffect.alertEffect)
        }
    }
}
