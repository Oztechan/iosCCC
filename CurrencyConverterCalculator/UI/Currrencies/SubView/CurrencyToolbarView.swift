//
//  CurrencyToolbarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 27/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct CurrencyToolbarView: View {
    
    @Binding var isFirstRun: Bool
    var functionBack: () -> Void
    var functionAllStateUpdate: (Bool) -> Void
    
    var body: some View {
        HStack {
            
            if !isFirstRun {
                Button(
                    action: { functionBack() },
                    label: {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .accentColor(Color("ColorText"))
                            .padding(.leading, 10)
                        
                        Text("Back").foregroundColor(Color("ColorText"))
                    }
                ).padding(.trailing, 10)
                
            }
            
            Spacer()
            Button(
                action: { functionAllStateUpdate(true) },
                label: { Text("Select All").foregroundColor(Color("ColorText")) }
            ).padding(.trailing, 10)
            Button(
                action: { functionAllStateUpdate(false) },
                label: { Text("Deselect All").foregroundColor(Color("ColorText")) }
            )
            
        }.padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 20))
    }
}

#if DEBUG
struct CurrencyToolbarViewPreview: PreviewProvider {
    static var previews: some View {
        CurrencyToolbarView(
            isFirstRun: .constant(false),
            functionBack: {},
            functionAllStateUpdate: {_ in }
        )
        CurrencyToolbarView(
            isFirstRun: .constant(false),
            functionBack: {},
            functionAllStateUpdate: {_ in }
        )
        .preferredColorScheme(.dark)
    }
}
#endif
