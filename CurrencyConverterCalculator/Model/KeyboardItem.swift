//
//  KeyboardItem.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 07/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

enum KeyboardItem: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case multiply = "*"
    case divide = "/"
    case minus = "-"
    case dot = "."
    case percentage = "%"
    case plus = "+"
    case tribleZero = "000"
    case ac = "AC"
    case del = "DEL"
    
    // swiftlint:disable cyclomatic_complexity
    func operateAction(input: String) -> String {
        switch self {
        case .zero :
            return input + "0"
        case .one :
            return input + "1"
        case .two :
            return input + "2"
        case .three :
            return input + "3"
        case .four :
            return input + "4"
        case .five :
            return input + "5"
        case .six :
            return input + "6"
        case .seven :
            return input + "7"
        case .eight :
            return input + "8"
        case .nine :
            return input + "9"
        case .multiply :
            return input + "*"
        case .divide :
            return input + "/"
        case .minus :
            return input + "-"
        case .dot :
            return input + "."
        case .percentage :
            return input + "%"
        case .plus :
            return input + "+"
        case .tribleZero :
            return input + "000"
        case .ac :
            return ""
        case .del :
            return String(input.dropLast())
        }
    }
}
