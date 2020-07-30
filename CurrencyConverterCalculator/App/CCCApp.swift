//
//  CCCApp.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 26/07/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import SwiftUI
import CoreData

@main
struct CCCApp: App {
    static let viewContext: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "CurrencyConverterCalculator")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
    var body: some Scene {
        WindowGroup {
            CalculatorView().environmentObject(EnviromentViewModel())
        }
    }
}
