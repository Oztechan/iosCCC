//
//  Extensions.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 11/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import Foundation

extension String {
    func toOutPutText(baseCurrency: CurrencyType) -> String {
        if self.isEmpty {
            return baseCurrency.stringValue
        } else {
            return "\(baseCurrency.stringValue.replacingOccurrences(of: "NULL", with: "")) = \(self)"
        }
    }
}
extension Array where Element == Currency {
    func filterResults(baseCurrency: CurrencyType) -> [Currency] {
        return self.filter { currency in
            currency.value != "0.0" &&
                currency.value != "0.00" &&
                currency.value != "0" &&
                currency.name != baseCurrency.stringValue &&
                CurrencyType.withLabel(currency.name) != CurrencyType.NULL &&
                currency.isActive
        }
    }
}

#if DEBUG
import SwiftUI

struct PreviewProviderModifier: ViewModifier {
    
    var includeLightMode: Bool
    var includeDarkMode: Bool
    var includeRightToLeftMode: Bool
    var includeLargeTextMode: Bool
    
    func body(content: Content) -> some View {
        Group {
            if includeLightMode {
                content
                    .previewDisplayName("Light Mode")
                    .environment(\.colorScheme, .light)
            }
            
            if includeDarkMode {
                content
                    .previewDisplayName("Dark Mode")
                    .environment(\.colorScheme, .dark)
            }
            
            if includeRightToLeftMode {
                content
                    .previewDisplayName("Right To Left")
                    .environment(\.layoutDirection, .rightToLeft)
            }
            
            if includeLargeTextMode {
                content
                    .previewDisplayName("Large Text")
                    .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
            }
        }
    }
    
}

extension View {
    func makeForPreviewProvider(
        includeLightMode: Bool = true,
        includeDarkMode: Bool = true,
        includeRightToLeftMode: Bool = true,
        includeLargeTextMode: Bool = true
    ) -> some View {
        modifier(
            PreviewProviderModifier(
                includeLightMode: includeLightMode,
                includeDarkMode: includeDarkMode,
                includeRightToLeftMode: includeRightToLeftMode,
                includeLargeTextMode: includeLargeTextMode
            )
        )
    }
    
}
#endif
