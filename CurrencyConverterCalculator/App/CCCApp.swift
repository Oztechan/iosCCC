//
//  CCCApp.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 26/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import SwiftUI
import CoreData

@main
struct CCCApp: App {
    
    @StateObject var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            if appViewModel.isFirstRun {
                CurrenciesView(
                    baseCurrency: $appViewModel.baseCurrency,
                    isFirstRun: $appViewModel.isFirstRun
                )
            } else {
                CalculatorView()
            }
        }
    }
}
