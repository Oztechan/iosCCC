//
//  CurrencyItem.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 08/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import CoreData

public class Currency: Identifiable, Codable {
    var name: String
    var longName: String
    var symbol: String
    var value: String = "0.0"
    var isActive: Bool = true

    private enum CodingKeys: String, CodingKey {
        case name
        case longName
        case symbol
    }
    
    init(
        name: String,
        longName: String,
        symbol: String
    ) {
        self.name = name
        self.longName = value
        self.symbol = symbol
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        longName = try container.decode(String.self, forKey: .longName)
        symbol = try container.decode(String.self, forKey: .symbol)
        value = "0.0"
        isActive =  true
    }
}
