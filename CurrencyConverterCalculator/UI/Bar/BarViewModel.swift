//
//  BarViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 30/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Combine

final class BarViewModel: ObservableObject {
    
    private let coreDataRepository = CoreDataRepository.shared
    
    @Published var currencyList = [Currency]()
    @Published var isLoading = true
    
    init() {
        initList()
    }
    
    private func initList() {
        self.currencyList = coreDataRepository.getAllCurrencies()
            .filter { $0.isActive}
        
        self.isLoading = false
    }
}
