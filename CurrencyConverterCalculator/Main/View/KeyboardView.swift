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
                KeyboardButton(keyboardItem: KeyboardItem.seven)
                KeyboardButton(keyboardItem: KeyboardItem.eight)
                KeyboardButton(keyboardItem: KeyboardItem.nine)
                KeyboardButton(keyboardItem: KeyboardItem.multiply)
            }
            HStack {
                KeyboardButton(keyboardItem: KeyboardItem.four)
                KeyboardButton(keyboardItem: KeyboardItem.five)
                KeyboardButton(keyboardItem: KeyboardItem.six)
                KeyboardButton(keyboardItem: KeyboardItem.divide)
            }
            HStack {
                KeyboardButton(keyboardItem: KeyboardItem.one)
                KeyboardButton(keyboardItem: KeyboardItem.two)
                KeyboardButton(keyboardItem: KeyboardItem.three)
                KeyboardButton(keyboardItem: KeyboardItem.minus)
            }
            HStack {
                KeyboardButton(keyboardItem: KeyboardItem.dot)
                KeyboardButton(keyboardItem: KeyboardItem.zero)
                KeyboardButton(keyboardItem: KeyboardItem.percentage)
                KeyboardButton(keyboardItem: KeyboardItem.plus)
                
            }
            HStack {
                KeyboardButton(keyboardItem: KeyboardItem.tribleZero)
                KeyboardButton(keyboardItem: KeyboardItem.ac)
                KeyboardButton(keyboardItem: KeyboardItem.del)
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
    @ObservedObject
    private var viewModel = MainViewModel()
    
    var keyboardItem: KeyboardItem
    var body: some View {
        Text(keyboardItem.rawValue)
            .font(.title)
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onTapGesture {
                self.viewModel.input = self.keyboardItem.operateAction(input: self.viewModel.input)
        }
    }
}

#if DEBUG
struct KeyboardViewPreviews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
#endif
