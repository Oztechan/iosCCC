//
//  AppViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 13/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

final class AppViewModel: ObservableObject {
    private let userDefaultRepository = UserDefaultsRepository()
    
    @Published var baseCurrency: CurrencyType {
        didSet {
            userDefaultRepository.setBaseCurrency(value: baseCurrency)
        }
    }
    @Published var isFirstRun: Bool {
        didSet {
            userDefaultRepository.setFirstRun(value: isFirstRun)
        }
    }
    
    init() {
        userDefaultRepository.register(defaults: [
            UserDefaultsRepository.UserDefaultsKeys.baseCurrency.rawValue: CurrencyType.NULL.stringValue,
            UserDefaultsRepository.UserDefaultsKeys.firstRun.rawValue: true
        ])
        
        self.baseCurrency = userDefaultRepository.getBaseCurrency()
        self.isFirstRun = userDefaultRepository.isFirstRun()
    }
}
