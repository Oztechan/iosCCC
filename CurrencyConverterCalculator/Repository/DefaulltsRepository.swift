//
//  UserDefaulltsRepository.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

class DefaultsRepository: UserDefaults {
    enum Keys: String {
        case baseCurrency
        case firstRun
    }
    
    var baseCurrency: CurrencyType {
        get { CurrencyType.withLabel(string(forKey: Keys.baseCurrency.rawValue)) }
        set { self.set(newValue.stringValue, forKey: Keys.baseCurrency.rawValue) }
    }
    
    var firstRun: Bool {
        get { bool(forKey: Keys.firstRun.rawValue) }
        set { self.set(newValue, forKey: Keys.firstRun.rawValue) }
    }
}
