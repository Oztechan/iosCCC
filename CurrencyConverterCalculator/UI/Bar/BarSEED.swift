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
    func selectCurrencyEvent(currency: Currency)
}

// MARK: Effect
enum BarEffect {
    case changeBaseCurrencyEffect(CurrencyType)
    case closeDiaogEffect
}

// MARK: Data
class BarData: AppData {
    let coreDataRepository = CoreDataRepository.shared
}
