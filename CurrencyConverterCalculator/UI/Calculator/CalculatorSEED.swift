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
    var isBarDialogShown = false
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
    
}

// MARK: Data
class CalculatorData: AppData {
    let coreDataRepository = CoreDataRepository.shared
    let apiRepository = ApiRepository()
    var rates: Rates?
    var cancelable: Cancellable?
}
