//
//  ContentView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 04/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject var viewModel: EnviromentViewModel
    @State var input = ""
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
                            Image(viewModel.baseCurrency.stringValue.lowercased())
                                .shadow(radius: 3)
                            Text(viewModel.getOutputText()).font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomLeading)
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        
                    }
                    .lineLimit(1)
                    .onTapGesture {
                        self.isBarDialogShown.toggle()
                    }.sheet(
                        isPresented: $isBarDialogShown,
                        content: { BarView(isBarDialogShown: $isBarDialogShown) }
                    )
                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Form {
                            List (viewModel.getFilteredList(), id: \.value) { currency in
                                CalculatorItemView(item: currency)
                            }.listRowBackground(Color("ColorBackground"))
                        }
                    }
                    
                    KeyboardView(input: $input)
                    
                }
            }
            .navigationBarTitle(input)
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: SettingsView(viewModel: EnviromentViewModel())
                ) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .accentColor(Color("ColorText"))
                }
            )
            
        }.accentColor(Color("ColorText"))
        .onAppear { self.viewModel.fetchRates() }
        
    }
}

#if DEBUG
struct CalculatorViewCalculatorViewPreviews: PreviewProvider {
    static var previews: some View {
        CalculatorView().environmentObject(EnviromentViewModel())
        CalculatorView().environmentObject(EnviromentViewModel()).preferredColorScheme(.dark)
    }
}
#endif
