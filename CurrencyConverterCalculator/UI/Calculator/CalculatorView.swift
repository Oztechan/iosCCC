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
    @State var isBarShown = false
    
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
                        destinationView: CurrenciesView(baseCurrencyChangeEffect: { newBase in
                            vm.event.baseCurrencyChangeEvent(newBase: newBase)
                        })
                    )
                    
                    CalculationOutputView(
                        baseCurrency: vm.state.baseCurrency,
                        output: vm.state.output,
                        barClickEvent: {vm.event.barClickEvent()}
                    )
                    
                    if vm.state.isLoading {
                        ProgressView()
                    }
                    
                    Form {
                        List(
                            vm.state.currencyList.filterResults(baseCurrency: vm.state.baseCurrency),
                            id: \.value
                        ) {
                            CalculatorItemView(
                                item: $0,
                                itemClickEvent: { item in vm.event.itemClickEvent(item: item) }
                            )
                        }.listRowBackground(Color("ColorBackground"))
                    }
                    
                    KeyboardView(keyPressEvent: { key in vm.event.keyPressEvent(value: key) })
                    
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(
            isPresented: $isBarShown,
            content: {
                BarView(
                    baseCurrencyChangeEvent: { newBase in
                        vm.event.baseCurrencyChangeEvent(newBase: newBase)
                    },
                    isBarShown: $isBarShown
                )
            }
        )
        .accentColor(Color("ColorText"))
        .onReceive(vm.effect) { observeEffects(effect: $0) }
        .onAppear { vm.fetchRates() }
        
    }
    
    private func observeEffects(effect: CalculatorEffect) {
        switch effect {
        case .showBarEffect:
            isBarShown = true
        }
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
