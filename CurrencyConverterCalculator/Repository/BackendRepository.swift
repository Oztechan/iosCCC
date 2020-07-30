//
//  BackendHelper.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 09/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine

class BackendRepository {
    static let shared = BackendRepository()
    
    func getRatesByBase(base: String) -> AnyPublisher<CurrencyResponse, Error> {
        let url = URL(string: "\(getBackendUrl())?base=\(base)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: CurrencyResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func getBackendUrl() -> String {
        return (Bundle.main.infoDictionary?["Backend Url"] as? String)?
            .replacingOccurrences(of: "\\", with: "") ?? "Here should be backend url, it can not be public"
    }
}
