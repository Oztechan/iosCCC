//
//  UserDefaulltsRepository.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

class UserDefaultsRepository: UserDefaults {
    
    enum UserDefaultsKeys: String {
        case baseCurrency
        case firstRun
    }
    
    func setBaseCurrency(value: CurrencyType) {
        set(value.stringValue, forKey: UserDefaultsKeys.baseCurrency.rawValue)
    }
    
    func getBaseCurrency() -> CurrencyType {
        return CurrencyType.withLabel(string(forKey: UserDefaultsKeys.baseCurrency.rawValue))
    }
    
    func setFirstRun(value: Bool) {
        set(value, forKey: UserDefaultsKeys.firstRun.rawValue)
    }
    
    func getBaseCurrency() -> Bool {
        return bool(forKey: UserDefaultsKeys.firstRun.rawValue)
    }
}
