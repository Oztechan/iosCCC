//
//  AppSEED.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 25/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

// MARK: State
struct AppState {
    var isFirstRun: Bool
}

protocol AppEvent {
    func firstRunChange()
}

// MARK: Data
class AppData {
    let defaults = UserDefaultsRepository()
    
    init() {
        defaults.register(defaults: [
            UserDefaultsRepository.UserDefaultsKeys.baseCurrency.rawValue: CurrencyType.NULL.stringValue,
            UserDefaultsRepository.UserDefaultsKeys.firstRun.rawValue: true
        ])
    }
}
