//
//  CurrencyResponse.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 09/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

struct CurrencyResponse: Codable {
    var base: String?
    var date: String?
    var rates: Rates?
}
