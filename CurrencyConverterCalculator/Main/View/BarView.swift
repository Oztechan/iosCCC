//
//  BarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct BarView: View {
    @Binding
    var input: String
    
    @Binding
    var output: String
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "PrimaryDark")!)
            VStack {
                Text(input)
                Text(output)
            }
            .font(.headline)
            .frame(height: 64)
            .foregroundColor(Color(UIColor(named: "Acent")!))
            .padding(.top, 32)
            .padding([.leading, .trailing], 16)
        }
        .frame(height: 96)
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {
    static var previews: some View {
        BarView(input: .constant("123"), output: .constant("321"))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
