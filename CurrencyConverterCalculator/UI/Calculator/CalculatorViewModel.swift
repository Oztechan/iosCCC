//
//  MainViewModel.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import Combine
import Expression
import Foundation

final class CalculatorViewModel: ObservableObject, CalculatorEvent {
    
    // MARK: SEED
    let effect = PassthroughSubject<CalculatorEffect, Never>()
    lazy var event = self as CalculatorEvent
    @Published var state = CalculatorState()
    var data = CalculatorData()
    
    private var cancelable: Cancellable?
    
    //    @Published var input = "" {
    //        didSet { calculateOutput() }
    //    }
    //    @Published var baseCurrency: CurrencyType {
    //        didSet {
    //            userDefaultRepository.setBaseCurrency(value: baseCurrency)
    //            fetchRates()
    //        }
    
    init() {
        state.baseCurrency = data.userDefaultRepository.getBaseCurrency()
        initList()
    }
    
    deinit { cancelable?.cancel() }
    
    private func calculateOutput() {
        state.isLoading = true
        let expression = Expression(state.input.replacingOccurrences(of: "%", with: "/100*"))
        do {
            let result = try expression.evaluate()
            
            data.output = String(format: "%.2f", result)
                .replacingOccurrences(of: "inf", with: "")
                .replacingOccurrences(of: "NULL", with: "")
            
        } catch {
            data.output = ""
        }
        updateList()
    }
    
    private func updateList() {
        if state.currencyList.isEmpty {
            initList()
        }
        
        if data.rates != nil {
            for index in 0..<(state.currencyList.count) {
                let rateOfCurrentRow = valueFor(
                    property: state.currencyList[index].name.lowercased(),
                    of: data.rates ?? 0.0
                )as? Double  ?? 0.0
                
                let expression = Expression("\(rateOfCurrentRow)*\(data.output)")
                
                do {
                    let result = try expression.evaluate()
                    state.currencyList[index].value = String(format: "%.2f", result)
                } catch {
                    state.currencyList[index].value = "0"
                }
            }
            
        } else {
            fetchRates()
        }
        
        state.isLoading  = false
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
        let allCurrencies = data.coreDataRepository.getAllCurrencies()
        
        allCurrencies.forEach { currency in
            if CurrencyType.withLabel(currency.name) != CurrencyType.NULL {
                state.currencyList.append(currency)
                
            }
        }
    }
    
    func fetchRates() {
        cancelable = data.apiRepository.getRatesByBase(base: state.baseCurrency.stringValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                if case let .failure(error) = $0 {
                    print(error)
                }
            }, receiveValue: {
                self.data.rates = $0.rates
                self.updateList()
            })
    }
    
    func getOutputText() -> String {
        if data.output.isEmpty {
            return state.baseCurrency.stringValue
        } else {
            return "\(state.baseCurrency.stringValue.replacingOccurrences(of: "NULL", with: "")) = \(data.output)"
        }
    }
    
}
extension Array where Element == Currency {
    func filterResults(baseCurrency: CurrencyType) -> [Currency] {
        return self.filter { currency in
            currency.value != "0.0" &&
                currency.value != "0.00" &&
                currency.value != "0" &&
                currency.name != baseCurrency.stringValue &&
                CurrencyType.withLabel(currency.name) != CurrencyType.NULL &&
                currency.isActive
        }
    }
}
