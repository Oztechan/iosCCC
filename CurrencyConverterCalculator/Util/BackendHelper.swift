//
//  BackendHelper.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 09/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine

// swiftlint:disable nesting
class BackendHelper {
    
    struct FetchRatesByBase: Publisher {
        typealias Output = CurrencyResponse
        typealias Failure = Error
        
        var base: Currencies
        func receive<S>(subscriber: S)
            where S: Subscriber,
            Failure == S.Failure,
            Output == S.Input {
                let request = URLRequest(url: URL(string: "\(getBackendUrl())?base=\(base)")!)
                URLSession.DataTaskPublisher(request: request, session: URLSession.shared)
                    .map { $0.data }
                    .decode(type: CurrencyResponse.self, decoder: JSONDecoder())
                    .receive(subscriber: subscriber)
        }
    }
    
    static func getBackendUrl() -> String {
        return (Bundle.main.infoDictionary?["Backend Url"] as? String)?
            .replacingOccurrences(of: "\\", with: "") ?? "Here should be backedn url, can not be public"
    }
}
