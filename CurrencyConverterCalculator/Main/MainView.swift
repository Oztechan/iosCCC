//
//  ContentView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 04/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject
    var viewModel: MainViewModel
    
    @State
    var input = ""
    
    var body: some View {
        
        VStack {
            BarView(input: $input, output: $viewModel.output)
            
            List {
                ForEach(viewModel.currencyList, id: \.value) { currency in
                    ItemView(item: currency)
                }
            }
            
            KeyboardView(input: self.$input)
        }
        .onAppear {
            self.viewModel.fetchRates()
        }
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
