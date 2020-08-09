//
//  CurrencyItem.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 08/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import CoreData

public class Currency: NSManagedObject, Identifiable, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case longName
        case symbol
        case value
        case isActive
    }
    
    // MARK: - Core Data Managed Object
    @NSManaged var name: String
    @NSManaged var longName: String
    @NSManaged var symbol: String
    @NSManaged var value: String
    @NSManaged var isActive: Bool
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Currency", in: managedObjectContext) else {
                fatalError("Failed to decode Currency")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.longName = try container.decode(String.self, forKey: .longName)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.value = "0.0"
        self.isActive =  true
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(longName, forKey: .longName)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(value, forKey: .value)
        try container.encode(isActive, forKey: .isActive)
    }
    
}

public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
