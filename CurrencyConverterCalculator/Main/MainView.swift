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
                
                BarView()
                
                if viewModel.isLoading {
                    IndicatorView()
                }
                
                List (viewModel.getFilteredList(), id: \.value) { currency in
                    MainItemView(item: currency)
                }
                
                KeyboardView(input: $input)
                
            }
            .navigationBarTitle(input)
            .navigationBarItems(
                trailing: NavigationLink(destination: SettingsView().environmentObject(self.viewModel)) {
                    Text("Settings")
                }
            )
            
        }
        .onAppear { self.viewModel.fetchRates() }
        
    }
}

#if DEBUG
struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(MainViewModel())
    }
}
#endif
