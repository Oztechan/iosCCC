//
//  SettingsItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct SettingsItemView: View {
    @Binding var item: CurrencyItem
    
    var body: some View {
        HStack {
            Image(item.shortCode.description.lowercased())
            Text(item.shortCode.description)
            Text(item.name)
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
                CurrencyItem(
                    value: "123",
                    name: "Euro",
                    symbol: "$",
                    shortCode: Currencies.USD,
                    imageName: "dollarsign.circle",
                    isActive: true
                )
            )
        )
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
