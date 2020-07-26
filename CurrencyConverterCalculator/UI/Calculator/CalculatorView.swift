//
//  ContentView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 04/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct CalculatorView: View {
    
    @Environment(\.managedObjectContext) var moc

    @EnvironmentObject var viewModel: EnviromentViewModel
    @State var input = ""
    
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
                    
                    BarView()
                    
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
                    destination: SettingsView(viewModel: EnviromentViewModel(moc: moc))
                ) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .accentColor(Color("ColorText"))
                }
            )
            
        }
        .onAppear { self.viewModel.fetchRates() }
        
    }
}

#if DEBUG
struct CalculatorViewCalculatorViewPreviews: PreviewProvider {
    @Environment(\.managedObjectContext) var moc

    static var previews: some View {
        CalculatorView().environmentObject(EnviromentViewModel(moc: CalculatorViewCalculatorViewPreviews().moc))
    }
}
#endif
