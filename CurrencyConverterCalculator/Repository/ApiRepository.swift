//
//  BackendHelper.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 09/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine

class ApiRepository {    
    func getRatesByBase(base: String) -> AnyPublisher<CurrencyResponse, Error> {
        
        #if DEBUG
        let url = URL(string: getUrl(key: "Debug Backend Url"))!
        #else
        let url = URL(string: "\(getUrl(key: "Production Backend Url"))?base=\(base)")!
        #endif
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: CurrencyResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func getUrl(key: String) -> String {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "") ?? "Here should be backend url, it can not be public"
    }
}
