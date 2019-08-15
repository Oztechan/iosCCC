//
//  ContentView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 04/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @State var input = "0"
    
    var body: some View {
        
        VStack {
            
            Text(input)
            Text("\(viewModel.baseCurrency.description) = \(viewModel.output)")
            
            List(viewModel.currencyList, id: \.self) { currency in
                ItemView(item: currency)
            }
            
            KeyboardView(input: self.$input)
            
        }
        .onAppear { self.viewModel.fetchRates() }
        .edgesIgnoringSafeArea(.all)
        
    }
    
}

#if DEBUG
struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(MainViewModel())
    }
}
#endif
