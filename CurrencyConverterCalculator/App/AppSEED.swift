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
    var baseCurrency: CurrencyType
    var isFirstRun: Bool
}

// MARK: Data
struct AppData {
    let userDefaultsRepository = UserDefaultsRepository()
    
    init() {
        userDefaultsRepository.register(defaults: [
            UserDefaultsRepository.UserDefaultsKeys.baseCurrency.rawValue: CurrencyType.NULL.stringValue,
            UserDefaultsRepository.UserDefaultsKeys.firstRun.rawValue: true
        ])
    }
}
