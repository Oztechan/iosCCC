//
//  KeyboardView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 06/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct KeyboardView: View {
    @Binding
    var input: String
    
    var body: some View {
        VStack {
            HStack {
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.seven)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.eight)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.nine)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.multiply)
            }
            HStack {
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.four)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.five)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.six)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.divide)
            }
            HStack {
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.one)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.two)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.three)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.minus)
            }
            HStack {
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.dot)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.zero)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.percentage)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.plus)
                
            }
            HStack {
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.tribleZero)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.ac)
                KeyboardButton(input: $input, keyboardItem: KeyboardItem.del)
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

struct KeyboardButton: View {
    @Binding
    var input: String
    
    var keyboardItem: KeyboardItem
    var body: some View {
        
        Button(
            action: {
                self.input = self.keyboardItem.operateAction(input: self.$input.value)
                
        },
            label: {
                Text(keyboardItem.rawValue)
                    .font(.title)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        )
    }
}

#if DEBUG
struct KeyboardViewPreviews: PreviewProvider {
    static var previews: some View {
        KeyboardView(input: .constant("123"))
    }
}
#endif
