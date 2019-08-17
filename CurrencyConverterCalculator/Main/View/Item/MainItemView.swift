//
//  ItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct MainItemView: View {
    
    var item: Currency
    
    var body: some View {
        HStack {
            Text(item.value)
            Text(item.symbol)
            Spacer()
            Text(item.name.stringValue)
            Image(item.name.stringValue.lowercased())
        }
    }
}

#if DEBUG
struct MainItemViewPreviews: PreviewProvider {
    static var previews: some View {
        MainItemView(
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
