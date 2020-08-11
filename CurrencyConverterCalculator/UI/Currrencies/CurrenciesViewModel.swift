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
    let effect = PassthroughSubject<CurrenciesEffect, Never>()
    lazy var event = self as CurrenciesEvent
    @Published var state = CurrenciesState()
    
    private let coreDataRepository = CoreDataRepository.shared
    private let userDefautRepository = UserDefaultsRepository()
    
    init() {
        self.initList()
    }
    
    private func initList() {
        state.currencyList = coreDataRepository.getAllCurrencies()
        state.isLoading = false
    }
    
    private func getFirstAvaiableBaseCurrencyOrNull() -> CurrencyType {
        return CurrencyType.withLabel(
            self.state.currencyList.filter { $0.isActive == true }.first?.name
        )
    }
    
    // MARK: Event
    func updateAllStates(state: Bool) {
        
        self.state.currencyList.forEach {
            $0.isActive = state
            coreDataRepository.updateCurrencyStateByName(name: $0.name, state: state)
        }
        let temp = self.state.currencyList
        self.state.currencyList = temp
        
        if !state {
            effect.send(CurrenciesEffect.changeBaseCurrency(CurrencyType.NULL))
        } else {
            if userDefautRepository.getBaseCurrency() == CurrencyType.NULL {
                effect.send(CurrenciesEffect.changeBaseCurrency(getFirstAvaiableBaseCurrencyOrNull()))
            } else {
                effect.send(CurrenciesEffect.changeBaseCurrency(userDefautRepository.getBaseCurrency()))
            }
        }
    }
    
    func updateState(currency: Currency) {
        state.currencyList.filter { $0.name == currency.name }.first?.isActive = !currency.isActive
        coreDataRepository.updateCurrencyStateByName(name: currency.name, state: !currency.isActive)
        
        if CurrencyType.withLabel(currency.name) == userDefautRepository.getBaseCurrency()
            || userDefautRepository.getBaseCurrency() == CurrencyType.NULL {
            effect.send( CurrenciesEffect.changeBaseCurrency(getFirstAvaiableBaseCurrencyOrNull()))
        } else {
            effect.send(CurrenciesEffect.changeBaseCurrency(userDefautRepository.getBaseCurrency()))
        }
    }
}
