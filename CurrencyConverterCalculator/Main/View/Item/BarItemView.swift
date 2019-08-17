//
//  SelectionView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct BarItemView: View {
    var item: Currency
    
    var body: some View {
        HStack {
            Image(item.name.stringValue.lowercased())
            Text(item.name.stringValue)
            Text(item.symbol)
        }
    }
}

#if DEBUG
struct BarItemViewPreviews: PreviewProvider {
    static var previews: some View {
        BarItemView(
            item: Currency(
                name: Currencies.USD,
                longName: "United StatesDolar",
                symbol: "$"
            )
        )
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
