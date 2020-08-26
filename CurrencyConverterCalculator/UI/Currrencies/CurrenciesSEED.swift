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
    func onDoneClick()
}

// MARK: Effect
enum CurrenciesEffect {
    case changeBaseCurrency(CurrencyType)
    case openCalculator
    case warningEffect
}

// MARK: Data
class CurrenciesData: AppData {
    let coreDataRepository = CoreDataRepository.shared
}
