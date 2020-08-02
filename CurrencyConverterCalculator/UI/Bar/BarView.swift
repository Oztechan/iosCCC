//
//  BarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 16/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI

struct BarView: View {
    
    @StateObject var barViewModel = BarViewModel()
    @Binding var isBarDialogShown: Bool
    var body: some View {
        
        NavigationView {
            if barViewModel.isLoading {
                ProgressView()
            }
            Form {
                List(self.barViewModel.currencyList, id: \.name) { currency in
                    
                    BarItemView(item: currency)
                        .onTapGesture {
                            self.barViewModel.baseCurrency = currency.name
                            self.isBarDialogShown = false
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                }.listRowBackground(Color("ColorBackground"))
            }.navigationBarTitle("Base Currency")
        }
    }
}

#if DEBUG
struct BarViewPreviews: PreviewProvider {    
    static var previews: some View {
        BarView(isBarDialogShown: .constant(true))
        BarView(isBarDialogShown: .constant(true)).preferredColorScheme(.dark)
    }
}
#endif
