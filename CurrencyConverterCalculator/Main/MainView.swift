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
        NavigationView {
            
            VStack {
                
                Form {
                    
                    Text(input)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                    Picker(
                        selection: $viewModel.baseCurrencyIndex,
                        label: Text("\(viewModel.baseCurrency.description) = \(viewModel.output)")
                    ) {
                        ForEach(self.viewModel.currencyList.map { $0.shortCode }, id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                    
                    if viewModel.isLoading {
                        IndicatorView()
                    } else {
                        List(viewModel.currencyList, id: \.self) { currency in
                            if !currency.value.isEqual("0.0") {
                                ItemView(item: currency)
                            }
                        }
                        
                    }
                }
                
                KeyboardView(input: self.$input)
                
            }
            
        }
        .onAppear { self.viewModel.fetchRates() }
        .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(MainViewModel())
    }
}
#endif
