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
    
    @StateObject var vm = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            if vm.state.calculatorViewVisibility {
                CalculatorView()
            } else {
                CurrenciesView(appInitialiseEvent: vm.event.appInitialiseEvent)
            }
            
        }
    }
}
