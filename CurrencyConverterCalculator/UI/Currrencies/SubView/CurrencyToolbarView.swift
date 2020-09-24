//
//  CurrencyToolbarView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 27/08/2020.
//  Copyright © 2020 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct CurrencyToolbarView: View {
    
    var firstRun: Bool
    var backClickEffect: () -> Void
    var updateAllEffect: (Bool) -> Void
    
    var body: some View {
        HStack {
            
            if !firstRun {
                Button(
                    action: backClickEffect,
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
                action: { updateAllEffect(true) },
                label: { Text("Select All").foregroundColor(Color("ColorText")) }
            ).padding(.trailing, 10)
            Button(
                action: { updateAllEffect(false) },
                label: { Text("Deselect All").foregroundColor(Color("ColorText")) }
            )
            
        }.padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 20))
    }
}

#if DEBUG
struct CurrencyToolbarViewPreview: PreviewProvider {
    static var previews: some View {
        CurrencyToolbarView(
            firstRun: false,
            backClickEffect: {},
            updateAllEffect: {_ in }
        )
        CurrencyToolbarView(
            firstRun: false,
            backClickEffect: {},
            updateAllEffect: {_ in }
        )
        .preferredColorScheme(.dark)
    }
}
#endif
