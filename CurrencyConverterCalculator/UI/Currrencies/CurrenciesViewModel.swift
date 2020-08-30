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
    @Published var state = CurrenciesState()
    let effect = PassthroughSubject<CurrenciesEffect, Never>()
    lazy var event = self as CurrenciesEvent
    var data = CurrenciesData()
    
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
        data.defaults.baseCurrency = newBase
        effect.send(CurrenciesEffect.changeBaseCurrencyEffect(newBase))
    }
    
    // MARK: Event
    func updateAllStates(state: Bool) {
        
        self.state.currencyList.forEach {
            $0.isActive = state
            data.coreDataRepository.updateCurrencyStateByName(name: $0.name, state: state)
        }
        let temp = self.state.currencyList
        self.state.currencyList = temp
        
        if !state {
            setBaseCurrency(newBase: CurrencyType.NULL)
        } else {
            if data.defaults.baseCurrency == CurrencyType.NULL {
                setBaseCurrency(newBase: getFirstAvaiableBaseCurrencyOrNull())
            }
        }
    }
    
    func updateState(currency: Currency) {
        state.currencyList.filter { $0.name == currency.name }.first?.isActive = !currency.isActive
        data.coreDataRepository.updateCurrencyStateByName(name: currency.name, state: !currency.isActive)
        
        if CurrencyType.withLabel(currency.name) == data.defaults.baseCurrency
            || data.defaults.baseCurrency == CurrencyType.NULL {
            setBaseCurrency(newBase: getFirstAvaiableBaseCurrencyOrNull())
        }
    }
    
    func onDoneClick() {
        if state.currencyList.filter({ $0.isActive == true}).count >= 2 {
            data.defaults.firstRun = false
            effect.send(CurrenciesEffect.openCalculatorEffect)
        } else {
            effect.send(CurrenciesEffect.warningEffect)
        }
    }
}
