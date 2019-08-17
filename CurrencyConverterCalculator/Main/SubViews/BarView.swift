//
//  BarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct BarView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @Binding var input: String
    @State var isPresented = false
    
    var body: some View {
        Button(
            action: {
                self.isPresented.toggle()
            },
            label: {
                Text(input).font(.headline)
                Text(viewModel.getOutputText()).font(.title)
            }
        ).sheet(
            isPresented: $isPresented,
            content: {
                NavigationView {
                    List (self.viewModel.currencyList, id: \.name) { currency in
                        BarItemView(item: currency)
                            .onTapGesture {
                                self.viewModel.baseCurrency = Currencies.withLabel(currency.name)
                                self.isPresented = false
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                    .navigationBarItems(
                        trailing: NavigationLink(destination: SettingsView().environmentObject(self.viewModel)) {
                            Text("Settings")
                        }
                    )
                    .navigationBarTitle("Base Currency")
                }
            }
        )
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {
    static var previews: some View {
        BarView(input: .constant("123"))
    }
}
#endif
