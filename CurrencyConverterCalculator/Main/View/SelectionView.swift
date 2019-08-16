//
//  SelectionView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct SelectionView: View {
    var item: CurrencyItem
    
    var body: some View {
        HStack {
            Image(item.shortCode.description.lowercased())
            Text(item.shortCode.description)
            Text(item.symbol)
        }
    }
}

#if DEBUG
struct SelectionViewPreviews: PreviewProvider {
    static var previews: some View {
        SelectionView(item: CurrencyItem(
            value: "123",
            symbol: "$",
            shortCode: Currencies.USD,
            imageName: "dollarsign.circle"
        ))
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
