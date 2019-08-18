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
            Image(item.name.lowercased())
            Text(item.name).frame(width: 45)
            Text(item.longName).font(.footnote)
            Text(item.symbol).font(.footnote)
            Spacer()
        }
        .lineLimit(1)
    }
}

#if DEBUG
struct BarItemViewPreviews: PreviewProvider {
    static var previews: some View {
        BarItemView(
            item: Currency(
                name: Currencies.USD.stringValue,
                longName: "United StatesDolar",
                symbol: "$"
            )
        )
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
