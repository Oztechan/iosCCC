//
//  AppViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 13/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

final class AppViewModel: ObservableObject, AppEvent {
    
    // MARK: SEED
    @Published
    private(set) var state: AppState
    private(set) lazy var event = self as AppEvent
    private(set) var data = AppData()
    
    init() {
        self.state = AppState(calculatorViewVisibility: !data.firstRun)
    }
    // MARK: Event
    func appInitialiseEvent() {
        data.firstRun = false
        state.calculatorViewVisibility = true
    }
}
