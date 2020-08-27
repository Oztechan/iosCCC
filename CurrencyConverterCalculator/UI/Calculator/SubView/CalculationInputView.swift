//
//  CalculationView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 27/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct CalculationInputView: View {
    
    var input: String
    var destinationView: CurrenciesView
    
    var body: some View {
        HStack {
            Spacer()
            Text(input)
                .foregroundColor(Color("ColorText"))
                .font(.title2)
            Spacer()
            NavigationLink(destination: destinationView) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .accentColor(Color("ColorText"))
                    .padding(.trailing, 15)
                
            }
        }.frame(width: .none, height: 40, alignment: .center)
    }
}

#if DEBUG
struct CalculationInputViewPreview: PreviewProvider {
    static var previews: some View {
        CalculationInputView(
            input: "1+2+3",
            destinationView: CurrenciesView(
                baseCurrency: .constant(CurrencyType.EUR),
                isFirstRun: .constant(false)
            )
        )
        CalculationInputView(
            input: "1+2+3",
            destinationView: CurrenciesView(
                baseCurrency: .constant(CurrencyType.EUR),
                isFirstRun: .constant(false)
            )
        )
        .preferredColorScheme(.dark)
    }
}
#endif
