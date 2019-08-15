//
//  NavBarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 15/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct NavBarView: View {
    @Binding var input: String
    @Binding var output: String
    @Binding var baseCurrency: Currencies
    
    var body: some View {
        VStack {
            
            Text(input)
            
            if output.isEmpty {
                Text(baseCurrency.description)
            } else {
                Text("\(output) \(baseCurrency.description)")
            }
        }
        
    }
}

#if DEBUG
struct NavBarViewPreviews: PreviewProvider {
    static var previews: some View {
        NavBarView(
            input: .constant("123"),
            output: .constant("321"),
            baseCurrency: .constant(Currencies.EUR)
        )
    }
}
#endif
