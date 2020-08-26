//
//  AppViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 13/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

final class AppViewModel: ObservableObject {
    
    // MARK: SEED
    @Published var state: AppState
    var data = AppData()
    
    init() {
        self.state = AppState(
            baseCurrency: data.defaults.getBaseCurrency(),
            isFirstRun: data.defaults.isFirstRun()
        )
    }
}
