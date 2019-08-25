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
    
}
