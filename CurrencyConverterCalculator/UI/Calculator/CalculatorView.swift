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
                            Image(vm.state.baseCurrency.stringValue.lowercased())
                                .shadow(radius: 3)
                            Text(vm.state.output.toOutPutText(baseCurrency: vm.state.baseCurrency)).font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomLeading)
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        
                    }
                    .lineLimit(1)
                    .onTapGesture {
                        vm.state.isBarDialogShown.toggle()
                    }.sheet(
                        isPresented: $vm.state.isBarDialogShown,
                        content: {
                            BarView(
                                isBarDialogShown: $vm.state.isBarDialogShown,
                                baseCurrency: $vm.state.baseCurrency
                            )
                        }
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
                    
                    KeyboardView(event: vm.event)
                    
                }
            }
            .navigationBarTitle(vm.state.input)
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: CurrenciesView(baseCurrency: $vm.state.baseCurrency, isFirstRun: .constant(false))
                ) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .accentColor(Color("ColorText"))
                }
            )
            
        }.accentColor(Color("ColorText"))
        .onAppear {
            self.vm.fetchRates()
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
