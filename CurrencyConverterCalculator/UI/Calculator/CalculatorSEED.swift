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
    func keyPressEvent(value: String)
    func baseCurrencyChangeEvent(newBase: CurrencyType)
    func itemClickEvent(item: Currency)
    func barClickEvent()
}

// MARK: Effect
enum CalculatorEffect {
    case showBarEffect
    case maximumInputEffect
    case fewCurrencyEffect
}

// MARK: Data
class CalculatorData: AppData {    
    let coreDataRepository = CoreDataRepository.shared
    let apiRepository = ApiRepository()
    var rates: Rates?
    var cancelable: Cancellable?
    let maximumInput = 15
    var alertText = ""
}
