//
//  BackendHelper.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 09/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

class BackendHelper {
    func getBackendUrl() -> String {
           return (Bundle.main.infoDictionary?["Backend Url"] as? String)?
               .replacingOccurrences(of: "\\", with: "") ?? ""
    }
}
