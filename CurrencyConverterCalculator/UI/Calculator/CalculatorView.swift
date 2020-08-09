//
//  ContentView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 04/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CalculatorView: View {
    @ObservedObject var calculatorViewModel = CalculatorViewModel()
    @State var isBarDialogShown = false
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 0,
                height: Double.leastNonzeroMagnitude
            )
        )
        UITableView.appearance().backgroundColor = UIColor(Color("ColorBackground"))
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("ColorBackgroundStrong").edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Image(calculatorViewModel.baseCurrency.stringValue.lowercased())
                                .shadow(radius: 3)
                            Text(calculatorViewModel.getOutputText()).font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomLeading)
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        
                    }
                    .lineLimit(1)
                    .onTapGesture {
                        self.isBarDialogShown.toggle()
                    }.sheet(
                        isPresented: $isBarDialogShown,
                        content: {
                            BarView(
                                isBarDialogShown: $isBarDialogShown,
                                baseCurrency: $calculatorViewModel.baseCurrency
                            )
                        }
                    )
                    
                    if calculatorViewModel.isLoading {
                        ProgressView()
                    }
                    
                    Form {
                        List(
                            calculatorViewModel.currencyList.filterResults(
                                baseCurrency: calculatorViewModel.baseCurrency
                            ),
                            id: \.value
                        ) { currency in
                            CalculatorItemView(item: currency)
                        }.listRowBackground(Color("ColorBackground"))
                    }
                    
                    KeyboardView(input: $calculatorViewModel.input)
                    
                }
            }
            .navigationBarTitle(calculatorViewModel.input)
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: SettingsView(baseCurrency: $calculatorViewModel.baseCurrency)
                ) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .accentColor(Color("ColorText"))
                }
            )
            
        }.accentColor(Color("ColorText"))
        .onAppear {
            self.calculatorViewModel.fetchRates()
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
