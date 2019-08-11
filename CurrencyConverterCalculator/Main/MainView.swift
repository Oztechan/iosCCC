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
    @State var input = ""
    
    var body: some View {
        
        VStack {
            BarView(input: $input, output: $viewModel.output)
            
            if viewModel.isLoading {
                IndicatorView()
            } else {
                List(viewModel.currencyList, id: \.self) { currency in
                    if !currency.value.isEqual("0.0") {
                        ItemView(item: currency)
                    }
                }
                .listRowBackground(Color(UIColor(named: "Primary")!))
            }
            
            KeyboardView(input: self.$input)
        }
        .background(Color(UIColor(named: "Primary")!))
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
