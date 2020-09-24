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
    @Published private(set) var state = CalculatorState()
    let effect = PassthroughSubject<CalculatorEffect, Never>()
    private(set) lazy var event = self as CalculatorEvent
    private(set) var data = CalculatorData()
    
    init() {
        state.baseCurrency = data.defaults.baseCurrency
        initList()
    }
    
    deinit { data.cancelable?.cancel() }
    
    private func calculateOutput() {
        state.isLoading = true
        let expression = Expression(state.input.replacingOccurrences(of: "%", with: "/100*"))
        do {
            let result = try expression.evaluate()
            
            state.output = String(format: "%.2f", result)
                .replacingOccurrences(of: "inf", with: "")
                .replacingOccurrences(of: "NULL", with: "")
            
        } catch {
            state.output = ""
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
                
                let expression = Expression("\(rateOfCurrentRow)*\(state.output)")
                
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
        state.isLoading = true
        data.cancelable = data.apiRepository.getRatesByBase(base: state.baseCurrency.stringValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                if case let .failure(error) = $0 {
                    print(error)
                }
                self.state.isLoading = false
            }, receiveValue: {
                self.data.rates = $0.rates
                self.updateList()
                self.state.isLoading = false
            })
    }
    
    // MARK: Event
    func keyPress(value: String) {
        switch value {
        case "AC":
            state.input = ""
            state.output = ""
        case "DEL":
            state.input = String(state.input.dropLast())
        default:
            state.input += value
        }
        calculateOutput()
    }
    
    func baseCurrencyChange(newBase: CurrencyType) {
        data.defaults.baseCurrency = newBase
        state.baseCurrency = newBase
        fetchRates()
    }
    
    func onItemClicked(item: Currency) {
        state.input = item.value
        baseCurrencyChange(newBase: CurrencyType.withLabel(item.name))
    }
    
    func onBarClick() {
        effect.send(CalculatorEffect.barEffect)
    }
}
