//
//  ItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    var body: some View {
        HStack {
            Text("12312312")
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
        ItemView()
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
