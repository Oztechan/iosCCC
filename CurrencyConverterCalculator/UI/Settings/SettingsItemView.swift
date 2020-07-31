//
//  SettingsItemView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct SettingsItemView: View {
    @ObservedObject var item: Currency
    
    @Environment(\.managedObjectContext) var managedObjectContext
        
    var body: some View {
        HStack {
            Image(item.name.lowercased())
                .shadow(radius: 3)
            Text(item.name).frame(width: 45)
            Text(item.longName).font(.footnote)
            Text(item.symbol).font(.footnote)
            Spacer()
            Image(systemName: item.isActive ? "checkmark.circle.fill" : "circle")
        }
        .onTapGesture { updateItem() }
        .lineLimit(1)
    }
    
    func updateItem() {
        item.isActive.toggle()
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

#if DEBUG
struct SettingsItemViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsItemView(item: Currency())
            .previewLayout(.fixed(width: 300, height: 36))
    }
}
#endif
