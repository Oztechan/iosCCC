//
//  UserDefaulltsRepository.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

class UserDefaultsRepository {
    func setBaseCurrency(value: CurrencyType) {
        UserDefaults.standard.setBaseCurrency(value: value)
    }
    func getBaseCurrency() -> CurrencyType {
        let baseCurrency = UserDefaults.standard.getBaseCurrency()
        
        if baseCurrency == CurrencyType.NULL {
            return CurrencyType.EUR
        } else {
            return baseCurrency
        }
    }
    
}

extension UserDefaults {
    
    func setBaseCurrency(value: CurrencyType) {
        set(value.stringValue, forKey: UserDefaultsKeys.baseCurrency.rawValue)
    }
    
    func getBaseCurrency() -> CurrencyType {
        return CurrencyType.withLabel(string(forKey: UserDefaultsKeys.baseCurrency.rawValue))
    }
}

enum UserDefaultsKeys: String {
    case baseCurrency
}
