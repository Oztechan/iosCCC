//
//  InitializationHelper.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

class InitializationHelper {
    struct ResponseData: Decodable {
        var currencies: [Currency]
    }

    static func loadJson(filename fileName: String) -> [Currency]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.currencies
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
