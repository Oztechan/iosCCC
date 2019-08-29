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
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        currencyRequest.sortDescriptors = [sortDescriptor]
        
        do {
            currencies = try self.moc.fetch(currencyRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return currencies
    }
    
    func insertInitialCurrency(initialCurrency: InititalCurrency) -> Currency? {
        
        let temCurrency = Currency(context: self.moc)
        temCurrency.name = initialCurrency.name
        temCurrency.longName = initialCurrency.longName
        temCurrency.symbol = initialCurrency.symbol
        temCurrency.value = "0.0"
        temCurrency.isActive = true
        
        do {
            try self.moc.save()
            return temCurrency
        } catch {
            print(error)
            return nil
        }
    }
    
    func updateCurrencyStateByName(name: String, state: Bool) {
        
        let currencyRequest: NSFetchRequest<Currency> = Currency.fetchRequest() as! NSFetchRequest<Currency>
        let predicate = NSPredicate(format: "name = '\(name)'")
        currencyRequest.predicate = predicate
        do {
            let object = try self.moc.fetch(currencyRequest)
            if object.count == 1 {
                object.first?.setValue(state, forKey: "isActive")
                do {
                    try self.moc.save()
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
}
