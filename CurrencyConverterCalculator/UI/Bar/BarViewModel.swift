//
//  BarViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine

final class BarViewModel: ObservableObject, BarEvent {
    // MARK: SEED
    @Published private(set) var state = BarState()
    let effect = PassthroughSubject<BarEffect, Never>()
    private(set) lazy var event = self as BarEvent
    private(set) var data = BarData()
    
    init() {
        initList()
    }
    
    private func initList() {
        self.state.currencyList = data.coreDataRepository.getAllCurrencies()
            .filter { $0.isActive}
        
        self.state.isLoading = false
    }
    
    private func setBaseCurrency(newBase: CurrencyType) {
        data.baseCurrency = newBase
        effect.send(BarEffect.changeBaseCurrencyEffect(newBase))
    }
    
    // MARK: Event
    func selectCurrencyEvent(currency: Currency) {
        setBaseCurrency(newBase: CurrencyType.withLabel(currency.name))
        effect.send(BarEffect.changeBaseCurrencyEffect(CurrencyType.withLabel(currency.name)))
        effect.send(BarEffect.closeDiaogEffect)
    }
}
