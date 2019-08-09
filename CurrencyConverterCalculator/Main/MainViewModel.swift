//
//  MainViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    private var cancelable: Cancellable?
    
    @Published
    var output = "0" {
        didSet { print("Output changed to \(self.output)") }
    }
    private var rates: Rates? = Rates()
    
    deinit { cancelable?.cancel() }
    
    func calculateOutput(input: String) {
        output = input // for now
    }
    
    func fetchRates(base: Currencies) {
        
        cancelable = BackendHelper.FetchRatesByBase(base: base)
            .sink(receiveCompletion: {
                if case let .failure(error) = $0 {
                    print(error)
                }
            }, receiveValue: {
                self.rates = $0.rates
            })
    }
}
