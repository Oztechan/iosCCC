//
//  AppSEED.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 25/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: State
struct AppState {
    var isAppInitialised: Bool
}

// MARK: Event
protocol AppEvent {
    func appInitialiseEvent()
}

// MARK: Data
struct AppData {
    @AppStorage(UserDefaultKeys.firstRun.rawValue)
    var firstRun = true
}
