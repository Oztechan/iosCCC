//
//  SettingsView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 17/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//
import SwiftUI
import Combine

struct CurrenciesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var baseCurrency: CurrencyType
    @Binding var isFirstRun: Bool
    @State var isAlertShown = false
    @ObservedObject var vm = CurrenciesViewModel()
    
    init(baseCurrency: Binding<CurrencyType>, isFirstRun: Binding<Bool>) {
        
        self._baseCurrency = baseCurrency
        self._isFirstRun = isFirstRun
        
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
        ZStack {
            
            Color("ColorBackgroundStrong").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                CurrencyToolbarView(
                    isFirstRun: $isFirstRun,
                    functionBack: { presentationMode.wrappedValue.dismiss() },
                    functionAllStateUpdate: { vm.updateAllStates(state: $0) }
                )
                
                if vm.state.isLoading {
                    ProgressView()
                }
                
                Form {
                    List(vm.state.currencyList, id: \.name) { currency in
                        CurrencyItemView(item: currency, function: {
                            vm.event.updateState(currency: currency)
                        })
                    }
                    .listRowBackground(Color("ColorBackground"))
                }
                
                if isFirstRun {
                    HStack {
                        
                        Text("Please select at east 2 ccurrencies")
                            .foregroundColor(Color("ColorText"))
                            .font(.subheadline)
                        Spacer()
                        Button(
                            action: { vm.event.onDoneClick() },
                            label: { Text("Done").foregroundColor(Color("ColorText")) }
                        )
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .background(Color("ColorBackgroundWeak"))
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                }
                
            }
            .navigationBarHidden(true)
        }
        .background(Color("ColorBackgroundStrong"))
        .onReceive(vm.effect) { observeEffects(effect: $0) }
        .alert(isPresented: $isAlertShown) {
            Alert(
                title: Text("Please select at east 2 ccurrencies"),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    private func observeEffects(effect: CurrenciesEffect) {
        switch effect {
        case .changeBaseCurrency(let newBase): baseCurrency = newBase
        case .openCalculator: isFirstRun = false
        case .warningEffect: isAlertShown = true
        }
    }
    
}

#if DEBUG
struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        CurrenciesView(
            baseCurrency: .constant(CurrencyType.EUR),
            isFirstRun: .constant(false)
        )
        CurrenciesView(
            baseCurrency: .constant(CurrencyType.EUR),
            isFirstRun: .constant(false)
        ).preferredColorScheme(.dark)
    }
}
#endif
