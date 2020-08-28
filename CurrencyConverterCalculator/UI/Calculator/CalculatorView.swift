//
//  ContentView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 04/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CalculatorView: View {
    @ObservedObject var vm = CalculatorViewModel()
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 0,
            height: Double.leastNonzeroMagnitude
        ))
        UITableView.appearance().backgroundColor = UIColor(Color("ColorBackground"))
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("ColorBackgroundStrong").edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    CalculationInputView(
                        input: vm.state.input,
                        destinationView: CurrenciesView(
                            isFirstRun: .constant(false),
                            baseCurrencyChange: {newBase in vm.event.baseCurrencyChange(newBase: newBase)}
                        )
                    )
                    
                    CalculationOutputView(
                        isBarDialogShown: $vm.state.isBarDialogShown,
                        baseCurrency: $vm.state.baseCurrency,
                        output: vm.state.output
                    )
                    
                    if vm.state.isLoading {
                        ProgressView()
                    }
                    
                    Form {
                        List(
                            vm.state.currencyList.filterResults(
                                baseCurrency: vm.state.baseCurrency
                            ),
                            id: \.value
                        ) { currency in
                            CalculatorItemView(item: currency)
                        }.listRowBackground(Color("ColorBackground"))
                    }
                    
                    KeyboardView(onKeyClick: { key in vm.event.keyPress(value: key) })
                    
                }
            }
            .navigationBarHidden(true)
        }
        .accentColor(Color("ColorText"))
        .onAppear { vm.fetchRates() }
        
    }
}

#if DEBUG
struct CalculatorViewCalculatorViewPreviews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
        CalculatorView().preferredColorScheme(.dark)
    }
}
#endif
