//
//  SettingsItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CurrencyItemView: View {
    @ObservedObject var item: Currency
    var updateCurrencyEvent: () -> Void
    
    var body: some View {
        HStack {
            
            Image(item.name.lowercased())
                .shadow(radius: 3)
            Text(item.name)
                .frame(width: 45)
                .foregroundColor(Color("ColorText"))
            Text(item.longName)
                .font(.footnote)
                .foregroundColor(Color("ColorText"))
            Text(item.symbol)
                .font(.footnote)
                .foregroundColor(Color("ColorText"))
            Spacer()
            Image(systemName: $item.isActive.wrappedValue ? "checkmark.circle.fill" : "circle")
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.$item.isActive.wrappedValue.toggle()
            updateCurrencyEvent()
        }
        .lineLimit(1)
    }
}

#if DEBUG
struct SettingsItemViewPreviews: PreviewProvider {
    static var previews: some View {
        CurrencyItemView(item: Currency(), updateCurrencyEvent: {})
            .previewLayout(.fixed(width: 300, height: 36))
    }
}
#endif
