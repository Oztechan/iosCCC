//
//  ItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    @Binding
    var value : String
    
    var body: some View {
        HStack {
            Text(value)
            Text("$")
            Spacer()
            Text("USD")
            Image(systemName: "dollarsign.circle")
        }
    }
}

#if DEBUG
struct ItemViewPreviews: PreviewProvider {
    static var previews: some View {
        ItemView(value: .constant("123"))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
