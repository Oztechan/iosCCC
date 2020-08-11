//
//  BarViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine

final class BarViewModel: ObservableObject, BarEvent {
    
    private let coreDataRepository = CoreDataRepository.shared
    
    // MARK: SEED
    let effect = PassthroughSubject<BarEffect, Never>()
    lazy var event = self as BarEvent
    @Published var state = BarState()
    
    init() {
        initList()
    }
    
    private func initList() {
        self.state.currencyList = coreDataRepository.getAllCurrencies()
            .filter { $0.isActive}
        
        self.state.isLoading = false
    }
    
    // MARK: Event
    func selectCurrency(currency: Currency) {
        effect.send(BarEffect.changeBaseCurrency(CurrencyType.withLabel(currency.name)))
        effect.send(BarEffect.closeDiaog)
    }
}
