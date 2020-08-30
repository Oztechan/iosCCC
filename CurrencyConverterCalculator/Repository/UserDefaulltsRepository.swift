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
    
    var baseCurrency: CurrencyType {
        get { CurrencyType.withLabel(string(forKey: UserDefaultsKeys.baseCurrency.rawValue)) }
        
        set { self.set(newValue.stringValue, forKey: UserDefaultsKeys.baseCurrency.rawValue) }
    }
    
    var firstRun: Bool {
        get { bool(forKey: UserDefaultsKeys.firstRun.rawValue) }
        set { self.set(newValue, forKey: UserDefaultsKeys.firstRun.rawValue) }
    }
}
