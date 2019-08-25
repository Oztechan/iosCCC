//
//  CoreDataManager.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 24/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // swiftlint:disable force_cast
    func getAllCurrencies() -> [Currency] {
        var currencies = [Currency]()
        
        let currencyRequest: NSFetchRequest<Currency> = Currency.fetchRequest() as! NSFetchRequest<Currency>
        
        do {
            currencies = try self.moc.fetch(currencyRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return currencies
    }
    
    func saveCurrency(currency: Currency) -> Bool {
        let temp = Currency(context: moc)
        temp.name = currency.name
        temp.longName = currency.longName
        temp.symbol = currency.symbol
        temp.value = "0.0"
        temp.isActive = true
        
        do {
            try self.moc.save()
            return true
        } catch {
            print(error)
            return false
        }
    }
}
