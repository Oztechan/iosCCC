//
//  CurrencyItem.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 08/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import CoreData

public class Currency: Identifiable {
    var name: Currencies
    var longName: String
    var symbol: String
    var value: String = "0.0"
    var isActive: Bool = true
    
    init(
        name: Currencies,
        longName: String,
        symbol: String
    ) {
        self.name =  name
        self.longName =  value
        self.symbol =  symbol
    }
}
