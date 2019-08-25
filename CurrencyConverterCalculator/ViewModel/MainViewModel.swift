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
    
    @Published var currencyList = [Currency]()
    var output = ""
    
    @Published var isLoading = true
    @Published var baseCurrency = Currencies.EUR {
        didSet { fetchRates() }
    }
    
    deinit { cancelable?.cancel() }
    
    func setBaseCurrency(base: String) {
        baseCurrency = Currencies.withLabel(base)
    }
    
    func calculateOutput(input: String) {
        isLoading = true
        let expression = Expression(input.replacingOccurrences(of: "%", with: "/100*"))
        do {
            let result = try expression.evaluate()
            
            output = String(format: "%.3f", result)
                .replacingOccurrences(of: "inf", with: "")
                .replacingOccurrences(of: "NULL", with: "")
            
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
                    property: currencyList[index].name.lowercased(),
                    of: rates ?? 0.0
                    )as? Double  ?? 0.0
                let expression = Expression("\(rateOfCurrentRow)*\(output)")
                do {
                    let result = try expression.evaluate()
                    currencyList[index].value = String(format: "%.3f", result)
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
        let database = CoreDataManager.shared.getAllCurrencies()
        
        if database.isEmpty {
            InitializationHelper.loadJson(filename: "Currencies")?.forEach { initialCurrency in
                if Currencies.withLabel(initialCurrency.name) != Currencies.NULL {
                    let temp = Currency(context: CoreDataManager.shared.moc)
                    temp.name = initialCurrency.name
                    temp.longName = initialCurrency.longName
                    temp.symbol = initialCurrency.symbol
                    temp.value = "0.0"
                    temp.isActive = true
                    
                    if CoreDataManager.shared.saveCurrency(currency: temp) {
                        
                        self.currencyList.append(temp)
                    }
                }
            }
        } else {
            database.forEach { currency in
                if Currencies.withLabel(currency.name) != Currencies.NULL {
                    self.currencyList.append(currency)
                    
                }
            }
        }
    }
    
    func getOutputText() -> String {
        if output.isEmpty {
            return baseCurrency.stringValue
        } else {
            return "\(output) \(baseCurrency.stringValue.replacingOccurrences(of: "NULL", with: ""))"
        }
    }
    
    func getFilteredList() -> [Currency] {
        return currencyList.filter { currency in
            currency.value != "0.0" &&
                currency.value != "0" &&
                currency.name != baseCurrency.stringValue &&
                Currencies.withLabel(currency.name) != Currencies.NULL &&
                currency.isActive
        }
    }
    
    func changeAllStates(state: Bool) {
        if !state {
            baseCurrency = Currencies.NULL
        } else {
            if baseCurrency == Currencies.NULL {
                baseCurrency = Currencies.EUR
            }
        }
        currencyList.forEach { $0.isActive = state }
    }
}
