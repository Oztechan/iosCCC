//
//  Extensions.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 11/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

extension String {
    func toOutPutText(baseCurrency: CurrencyType) -> String {
        if self.isEmpty {
            return baseCurrency.stringValue
        } else {
            return "\(baseCurrency.stringValue.replacingOccurrences(of: "NULL", with: "")) = \(self)"
        }
    }
}
extension Array where Element == Currency {
    func filterResults(baseCurrency: CurrencyType) -> [Currency] {
        return self.filter { currency in
            currency.value != "0.0" &&
                currency.value != "0.00" &&
                currency.value != "0" &&
                currency.name != baseCurrency.stringValue &&
                CurrencyType.withLabel(currency.name) != CurrencyType.NULL &&
                currency.isActive
        }
    }
}
