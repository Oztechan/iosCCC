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
    private var baseCurrency = Currencies.EUR
    private var rates: Rates? = Rates()
    
    var currencyList = [CurrencyItem]()
    
    @Published
    var output = "0"
    
    deinit { cancelable?.cancel() }
    
    func calculateOutput(input: String) {
        var temp = input
        
        temp = temp.replacingOccurrences(of: "%", with: "/100*")
        
        let expression = Expression(temp)
        do {
            let result = try expression.evaluate()
            print("Input \(temp) Result: \(result)")
            output = String(result)
        } catch {
            output = "0"
            print("Input \(temp) Error: \(error)")
        }
        updateList()
    }
    
    func fetchRates() {
        
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
                    property: currencyList[index].shortCode.lowercased(),
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
            print(currency)
            self.currencyList.append(
                CurrencyItem(
                    value: output,
                    symbol: "$",
                    shortCode: currency.description,
                    imageName: "dollarsign.circle"
                )
            )
        }
    }
}
