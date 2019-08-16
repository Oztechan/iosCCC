//
//  ItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct MainItemView: View {
    
    var item: CurrencyItem
    
    var body: some View {
        HStack {
            Image(item.shortCode.description.lowercased())
            
            Spacer()
            Text(item.shortCode.description)
            Text(item.symbol)
            
        }
    }
}

#if DEBUG
struct MainItemViewPreviews: PreviewProvider {
    static var previews: some View {
        MainItemView(item: CurrencyItem(
            value: "123",
            name: "Euro",
            symbol: "$",
            shortCode: Currencies.USD,
            imageName: "dollarsign.circle",
            isActive: true
        ))
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
