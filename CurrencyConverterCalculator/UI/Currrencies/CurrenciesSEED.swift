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
    func updateAllEvent(state: Bool)
    func updateCurrencyEvent(currency: Currency)
    func doneClickEvent()
}

// MARK: Effect
enum CurrenciesEffect {
    case baseCurrencyChangeEffect(CurrencyType)
    case appInitialiseEffect
    case alertEffect
}

// MARK: Data
class CurrenciesData: AppData {
    let coreDataRepository = CoreDataRepository.shared
}
