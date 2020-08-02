//
//  UserDefaulltsRepository.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

class UserDefaultsRepository {
    func setBaseCurrency(value: Currencies) {
        UserDefaults.standard.setBaseCurrency(value: value)
    }
    func getBaseCurrency() -> Currencies {
        let baseCurrency = UserDefaults.standard.getBaseCurrency()
        
        if baseCurrency == Currencies.NULL {
            return Currencies.EUR
        } else {
            return baseCurrency
        }
    }
    
}

extension UserDefaults {
    
    func setBaseCurrency(value: Currencies) {
        set(value.stringValue, forKey: UserDefaultsKeys.baseCurrency.rawValue)
    }
    
    func getBaseCurrency() -> Currencies {
        return Currencies.withLabel(string(forKey: UserDefaultsKeys.baseCurrency.rawValue))
    }
}

enum UserDefaultsKeys: String {
    case baseCurrency
}
