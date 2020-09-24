//
//  CalculatorSEED.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 11/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine

// MARK: State
struct CalculatorState {
    var input = ""
    var output = ""
    var currencyList = [Currency]()
    var isLoading = false
    var baseCurrency = CurrencyType.NULL
}

// MARK: Event
protocol CalculatorEvent {
    func keyPress(value: String)
    func baseCurrencyChange(newBase: CurrencyType)
    func onItemClicked(item: Currency)
    func onBarClick()
}

// MARK: Effect
enum CalculatorEffect {
    case barEffect
}

// MARK: Data
struct CalculatorData {
    let defaults = DefaultsRepository()
    
    init() {
        defaults.register(defaults: [
            DefaultsRepository.Keys.baseCurrency.rawValue: CurrencyType.NULL.stringValue,
            DefaultsRepository.Keys.firstRun.rawValue: true
        ])
    }
    
    let coreDataRepository = CoreDataRepository.shared
    let apiRepository = ApiRepository()
    var rates: Rates?
    var cancelable: Cancellable?
}
