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
            
            ZStack {
                Color(UIColor(named: "PrimaryDark")!)
                VStack {
                    Text(input)
                    Text("\(viewModel.baseCurrency.description) = \(viewModel.output)")
                }
                .font(.headline)
                .frame(height: 64)
                .foregroundColor(Color(UIColor(named: "Acent")!))
                .padding(.top, 32)
                .padding([.leading, .trailing], 16)
            }
            .frame(height: 96)
            
            Form {
                if viewModel.isLoading {
                    IndicatorView()
                } else {
                    List(viewModel.currencyList, id: \.self) { currency in
                        ItemView(item: currency)
                    }.listRowBackground(Color(UIColor(named: "Primary")!))
                        .background(Color(UIColor(named: "Primary")!))
                    
                }
            }
            
            KeyboardView(input: self.$input)
            
        }
            
        .background(Color(UIColor(named: "PrimaryDark")!))
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
