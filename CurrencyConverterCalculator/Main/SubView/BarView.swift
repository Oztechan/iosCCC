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
    @State var isPresented = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Image(viewModel.baseCurrency.stringValue.lowercased())
                Text(viewModel.getOutputText()).font(.headline)
                Spacer()
            }.padding()
            
        }
        .lineLimit(1)
        .onTapGesture {
            self.isPresented.toggle()
        }.sheet(
            isPresented: $isPresented,
            content: {
                NavigationView {
                    
                    List(self.viewModel.currencyList.filter {
                        $0.isActive &&
                            $0.name != self.viewModel.baseCurrency.stringValue
                    }, id: \.name) { currency in
                        
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
        
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {
    static var previews: some View {
        BarView().environmentObject(MainViewModel())
    }
}
#endif
