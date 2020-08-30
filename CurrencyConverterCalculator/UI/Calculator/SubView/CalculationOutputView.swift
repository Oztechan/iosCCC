//
//  CalculationOutputView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 27/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CalculationOutputView: View {
    
    var baseCurrency: CurrencyType
    var output: String
    var onBarCick: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image(baseCurrency.stringValue.lowercased()).shadow(radius: 3)
                Text(output.toOutPutText(baseCurrency: baseCurrency)).foregroundColor(Color("ColorText"))
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomLeading)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
        }
        .lineLimit(1)
        .onTapGesture { onBarCick() }
    }
}

#if DEBUG
struct CalculationOutputViewPreview: PreviewProvider {
    static var previews: some View {
        CalculationOutputView(
            baseCurrency: CurrencyType.EUR,
            output: "123",
            onBarCick: {}
        )
        CalculationOutputView(
            baseCurrency: CurrencyType.EUR,
            output: "123",
            onBarCick: {}
        )
        .preferredColorScheme(.dark)
    }
}
#endif
