//
//  KeyboardView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct KeyboardView: View {
    var body: some View {
        VStack {
            HStack {
                KeyboardItem(itemIdentifer: "7")
                KeyboardItem(itemIdentifer: "8")
                KeyboardItem(itemIdentifer: "9")
                KeyboardItem(itemIdentifer: "*")
            }
            HStack {
                KeyboardItem(itemIdentifer: "4")
                KeyboardItem(itemIdentifer: "5")
                KeyboardItem(itemIdentifer: "6")
                KeyboardItem(itemIdentifer: "/")
            }
            HStack {
                KeyboardItem(itemIdentifer: "1")
                KeyboardItem(itemIdentifer: "2")
                KeyboardItem(itemIdentifer: "3")
                KeyboardItem(itemIdentifer: "-")
            }
            HStack {
                KeyboardItem(itemIdentifer: ".")
                KeyboardItem(itemIdentifer: "0")
                KeyboardItem(itemIdentifer: "%")
                KeyboardItem(itemIdentifer: "+")
                
            }
            HStack {
                KeyboardItem(itemIdentifer: "000")
                KeyboardItem(itemIdentifer: "AC")
                KeyboardItem(itemIdentifer: "DEL")
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(Color(UIColor(named: "PrimaryDark")!))
        .foregroundColor(Color(UIColor(named: "Acent")!))
    }
}

struct KeyboardItem: View {
    var itemIdentifer: String
    var body: some View {
        Text(itemIdentifer)
            .font(.title)
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

#if DEBUG
struct KeyboardViewPreviews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
#endif
