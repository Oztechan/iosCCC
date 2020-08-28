//
//  CalculationOutputView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 27/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CalculationOutputView: View {
    
    @Binding var isBarDialogShown: Bool
    var baseCurrency: CurrencyType
    var baseCurrencyChange: (CurrencyType) -> Void
    var output: String
    
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
        .onTapGesture {
            isBarDialogShown.toggle()
        }.sheet(
            isPresented: $isBarDialogShown,
            content: {
                BarView(
                    isBarDialogShown: $isBarDialogShown,
                    baseCurrencyChange: baseCurrencyChange
                )
            }
        )
    }
}

#if DEBUG
struct CalculationOutputViewPreview: PreviewProvider {
    static var previews: some View {
        CalculationOutputView(
            isBarDialogShown: .constant(true),
            baseCurrency: CurrencyType.EUR,
            baseCurrencyChange: {_ in},
            output: "123"
        )
        CalculationOutputView(
            isBarDialogShown: .constant(true),
            baseCurrency: CurrencyType.EUR,
            baseCurrencyChange: {_ in},
            output: "123"
        )
        .preferredColorScheme(.dark)
    }
}
#endif
