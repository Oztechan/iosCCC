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
        
        NavigationView {
            
            VStack {
                
                Form {
                    
                    Text(input)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .background(Color(UIColor(named: "PrimaryDark")!))
                        .foregroundColor(Color(UIColor(named: "Acent")!))
                        .listRowBackground(Color(UIColor(named: "PrimaryDark")!))
                    Picker(
                        selection: $viewModel.baseCurrencyIndex,
                        label: Text("\(viewModel.baseCurrency.description) = \(viewModel.output)")
                    ) {
                        ForEach(self.viewModel.currencyList.map { $0.shortCode.description }, id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }.listRowBackground(Color(UIColor(named: "PrimaryDark")!))
                        .background(Color(UIColor(named: "PrimaryDark")!))
                        .foregroundColor(Color(UIColor(named: "Acent")!))
                    
                    if viewModel.isLoading {
                        IndicatorView()
                    } else {
                        List(viewModel.currencyList, id: \.self) { currency in
                            ItemView(item: currency)
                        }
                        .listRowBackground(Color(UIColor(named: "Primary")!))
                        
                    }
                    
                }
                
                KeyboardView(input: self.$input)
                
            }
            .background(Color(UIColor(named: "PrimaryDark")!))
        }
        .background(Color(UIColor(named: "PrimaryDark")!))
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
