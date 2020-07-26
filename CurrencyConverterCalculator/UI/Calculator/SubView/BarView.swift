//
//  BarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct BarView: View {
    
    @EnvironmentObject var viewModel: EnviromentViewModel
    @State var isPresented = false
    
    var body: some View {
        
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
    @Environment(\.managedObjectContext) var moc

    static var previews: some View {
        BarView().environmentObject(EnviromentViewModel(moc: BarViewPreviews().moc))
    }
}
#endif
