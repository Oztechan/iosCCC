//
//  MainViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine
import Expression

final class MainViewModel: ObservableObject {
    
    private var cancelable: Cancellable?
    private var rates: Rates? = Rates()
    
    var currencyList = [CurrencyItem]()
    var output = ""
    
    @Published var isLoading = true
    @Published var baseCurrency = Currencies.EUR {
        didSet { fetchRates() }
    }
    
    deinit { cancelable?.cancel() }
    
    func calculateOutput(input: String) {
        isLoading = true
        let expression = Expression(input.replacingOccurrences(of: "%", with: "/100*"))
        do {
            let result = try expression.evaluate()
            output = String(result)
        } catch {
            output = ""
        }
        updateList()
    }
    
    func fetchRates() {
        isLoading  = true
        cancelable = BackendHelper.FetchRatesByBase(base: baseCurrency)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                if case let .failure(error) = $0 {
                    print(error)
                }
            }, receiveValue: {
                self.rates = $0.rates
                self.updateList()
            })
    }
    
    func updateList() {
        if currencyList.isEmpty {
            initList()
        }
        
        if rates != nil {
            for index in 0..<(currencyList.count) {
                let rateOfCurrentRow = valueFor(
                    property: currencyList[index].shortCode.description.lowercased(),
                    of: rates ?? 0.0
                    )as? Double  ?? 0.0
                let expression = Expression("\(rateOfCurrentRow)*\(output)")
                do {
                    let result = try expression.evaluate()
                    currencyList[index].value = String(result)
                } catch {
                    currencyList[index].value = "0"
                }
            }
            
        } else {
            fetchRates()
        }
        
        isLoading  = false
    }
    
    func isNilDescendant(_ any: Any?) -> Bool {
        return String(describing: any) == "Optional(nil)"
    }
    
    func valueFor(property: String, of object: Any) -> Any? {
        let mirror = Mirror(reflecting: object)
        if let child = mirror.descendant(property), !isNilDescendant(child) {
            return child
        } else {
            return nil
        }
    }
    
    func initList() {
        Currencies.allCases.forEach { currency in
            self.currencyList.append(
                CurrencyItem(
                    value: output,
                    symbol: "",
                    shortCode: currency,
                    imageName: currency.description.lowercased()
                )
            )
        }
    }
    
    func getOutputText() -> String {
        if output.isEmpty {
            return baseCurrency.description
        } else {
            return "\(output) \(baseCurrency.description)"
        }
    }
}
