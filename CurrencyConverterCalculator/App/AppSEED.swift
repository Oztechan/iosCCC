//
//  AppSEED.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 25/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: State
struct AppState {
    var calculatorViewVisibility: Bool
}

// MARK: Event
protocol AppEvent {
    func appInitialiseEvent()
}

// MARK: Data
class AppData {
    private let defaults = DefaultsRepository()
    
    var baseCurrency: CurrencyType {
        get { return defaults.baseCurrency }
        set { defaults.baseCurrency = newValue }
    }
    
    var firstRun: Bool {
        get { return defaults.firstRun }
        set { defaults.firstRun = newValue }
    }
    
    init() {
        defaults.register(defaults: [
            DefaultsRepository.Keys.baseCurrency.rawValue: CurrencyType.NULL.stringValue,
            DefaultsRepository.Keys.firstRun.rawValue: true
        ])
    }

}
