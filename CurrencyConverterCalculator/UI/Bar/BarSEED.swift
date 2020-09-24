//
//  BarSEED.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 11/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

// MARK: State
struct BarState {
    var currencyList = [Currency]()
    var isLoading = false
}

// MARK: Event
protocol BarEvent {
    func selectCurrency(currency: Currency)
}

// MARK: Effect
enum BarEffect {
    case changeBaseCurrency(CurrencyType)
    case closeDiaog
}

// MARK: Data
struct BarData {
    let defaults = DefaultsRepository()
    
    init() {
        defaults.register(defaults: [
            DefaultsRepository.Keys.baseCurrency.rawValue: CurrencyType.NULL.stringValue,
            DefaultsRepository.Keys.firstRun.rawValue: true
        ])
    }
    let coreDataRepository = CoreDataRepository.shared
}
