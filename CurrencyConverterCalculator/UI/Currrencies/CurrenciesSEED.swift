//
//  CurrenciesSEED.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 11/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

// MARK: State
struct CurrenciesState {
    var currencyList = [Currency]()
    var isLoading = false
}

// MARK: Event
protocol CurrenciesEvent {
    func updateAllStates(state: Bool)
    func updateState(currency: Currency)
}

// MARK: Effect
enum CurrenciesEffect {
    case changeBaseCurrency(CurrencyType)
}

// MARK: Data
struct CurrenciesData {
    let coreDataRepository = CoreDataRepository.shared
    let userDefautRepository = UserDefaultsRepository()
}
