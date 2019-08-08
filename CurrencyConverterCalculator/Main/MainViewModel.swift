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
    
    @Published
    var output = "0" {
        didSet { print("Output changed to \(self.output)") }
    }
    
    func calculateOutput(input: String) {
        output = input // for now
    }
}
