//
//  ItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    
    var item: CurrencyItem
    
    var body: some View {
        HStack {
            Text(item.value)
            Text(item.symbol)
            Spacer()
            Text(item.shortCode)
            Image(item.shortCode.lowercased())
        }
    }
}

#if DEBUG
struct ItemViewPreviews: PreviewProvider {
    static var previews: some View {
        ItemView(item: CurrencyItem(
            value: "123",
            symbol: "$",
            shortCode: "USD",
            imageName: "dollarsign.circle"
        ))
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
