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
    
    let willChange = PassthroughSubject<MainViewModel, Never>()
    
    @Published
    var input = "Test Input" {
        didSet { willChange.send(self) }
    }
}
