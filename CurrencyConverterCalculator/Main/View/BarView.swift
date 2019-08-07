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
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "PrimaryDark")!)
            VStack {
                Color(UIColor(named: "PrimaryDark")!)
                HStack {
                    Text(input)
                        .padding(.horizontal, 8)
                        .frame(height: 32)
                        .foregroundColor(Color(UIColor(named: "Acent")!))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)
            }
            .padding([.leading, .trailing], 16)
        }
        .frame(height: 64)
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {
    static var previews: some View {
        BarView(input: .constant("123"))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
