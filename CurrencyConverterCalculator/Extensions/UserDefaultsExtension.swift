//
//  UserDefaultsExtension.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 25/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setBaseCurrency(value: Currencies) {
        set(value.stringValue, forKey: UserDefaultsKeys.baseCurrency.rawValue)
    }

    func getBaseCurrency() -> Currencies {
        return Currencies.withLabel(string(forKey: UserDefaultsKeys.baseCurrency.rawValue))
    }
}
