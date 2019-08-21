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
    @State var isPresented = false
    
    var body: some View {
        
        NavigationView{
        VStack {
            
            HStack {
                HStack {
                    Image(viewModel.baseCurrency.stringValue.lowercased())
                    Text(input)
                    Text(viewModel.baseCurrency.stringValue)
                }.onTapGesture {
                    self.isPresented.toggle()
                }
                
                Spacer()
                NavigationLink(destination: SettingsView().environmentObject(self.viewModel)) {
                    Text("Settings")
                }
            }.padding()
            
            if viewModel.isLoading {
                IndicatorView()
            }
            
            List (viewModel.getFilteredList(), id: \.value) { currency in
                MainItemView(item: currency)
            }
            
            KeyboardView(input: $input)
            
        }.navigationBarHidden(true).edgesIgnoringSafeArea(.top)
        
        .sheet(
            isPresented: $isPresented,
            content: {
                NavigationView {
                    List(self.viewModel.currencyList.filter { $0.isActive }, id: \.name) { currency in
                        BarItemView(item: currency)
                            .onTapGesture {
                                self.viewModel.baseCurrency = Currencies.withLabel(currency.name)
                                self.isPresented = false
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        
                    }
                    .navigationBarTitle("Base Currency")
                    
                }
        }
        )
        
        }.onAppear { self.viewModel.fetchRates() }
        
    }
}

#if DEBUG
struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(MainViewModel())
    }
}
#endif
