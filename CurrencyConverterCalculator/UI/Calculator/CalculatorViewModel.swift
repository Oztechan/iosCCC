//
//  MainViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import Combine
import Expression
import SwiftUI

final class CalculatorViewModel: ObservableObject {
    
    private let coreDataRepository = CoreDataRepository.shared
    private let apiRepository = ApiRepository()
    private let userDefaultRepository = UserDefaultsRepository()
    
    private var cancelable: Cancellable?
    private var rates: Rates? = Rates()
    
    @Published var input = "" {
        didSet { calculateOutput() }
    }
    @Published var currencyList = [Currency]()
    @Published var isLoading = false

    @AppStorage(UserDefaultsKeys.baseCurrency.rawValue)
    var baseCurrency: String = Currencies.NULL.stringValue
    
    var output = ""
    
    init() {
        initList()
    }
    
    deinit { cancelable?.cancel() }
    
    private func calculateOutput() {
        isLoading = true
        let expression = Expression(input.replacingOccurrences(of: "%", with: "/100*"))
        do {
            let result = try expression.evaluate()
            
            output = String(format: "%.2f", result)
                .replacingOccurrences(of: "inf", with: "")
                .replacingOccurrences(of: "NULL", with: "")
            
        } catch {
            output = ""
        }
        updateList()
    }
    
    private func updateList() {
        if currencyList.isEmpty {
            initList()
        }
                
        if rates != nil {
            for index in 0..<(currencyList.count) {
                let rateOfCurrentRow = valueFor(
                    property: currencyList[index].name.lowercased(),
                    of: rates ?? 0.0
                )as? Double  ?? 0.0
                
                let expression = Expression("\(rateOfCurrentRow)*\(output)")
                
                do {
                    let result = try expression.evaluate()
                    currencyList[index].value = String(format: "%.2f", result)
                } catch {
                    currencyList[index].value = "0"
                }
            }
            
        } else {
            fetchRates()
        }
                
        isLoading  = false
    }
    
    private func isNilDescendant(_ any: Any?) -> Bool {
        return String(describing: any) == "Optional(nil)"
    }
    
    private func valueFor(property: String, of object: Any) -> Any? {
        let mirror = Mirror(reflecting: object)
        if let child = mirror.descendant(property), !isNilDescendant(child) {
            return child
        } else {
            return nil
        }
    }
    
    private func initList() {
        let allCurrencies = coreDataRepository.getAllCurrencies()
        
        allCurrencies.forEach { currency in
            if Currencies.withLabel(currency.name) != Currencies.NULL {
                self.currencyList.append(currency)
                
            }
        }
    }
    
    func fetchRates() {
        cancelable = apiRepository.getRatesByBase(base: baseCurrency)
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
    
    func getOutputText() -> String {
        if output.isEmpty {
            return baseCurrency
        } else {
            return "\(baseCurrency.replacingOccurrences(of: "NULL", with: "")) = \(output)"
        }
    }
    
}
extension Array where Element == Currency {
    func filterResults(baseCurrency: String) -> [Currency] {
      return self.filter { currency in
        currency.value != "0.0" &&
            currency.value != "0.00" &&
            currency.value != "0" &&
            currency.name != baseCurrency &&
            Currencies.withLabel(currency.name) != Currencies.NULL &&
            currency.isActive
    }
    }
}
