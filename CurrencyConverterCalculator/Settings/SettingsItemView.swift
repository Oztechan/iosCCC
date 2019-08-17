//
//  SettingsItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct SettingsItemView: View {
    @Binding var item: Currency
    
    var body: some View {
        HStack {
            Image(item.name.lowercased())
            Text(item.name)
            Text(item.longName)
            Text(item.symbol)
            Spacer()
            Toggle(isOn: $item.isActive) { EmptyView() }.padding()
        }
    }
}

#if DEBUG
struct SettingsItemViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsItemView(
            item: .constant(
                Currency(
                    name: Currencies.USD.stringValue,
                    longName: "United StatesDolar",
                    symbol: "$"
                )
            )
        )
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
