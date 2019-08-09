//
//  CurrencyItem.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 08/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

struct CurrencyItem {
    var value: String
    var symbol: String = "$"
    var shortCode: String = "USD"
    var imageName: String = "dollarsign.circle"
    
    init(value: String) {
        self.value = value
    }
}
