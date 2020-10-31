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
    var backClickEvent: () -> Void
    var updateAllEvent: (Bool) -> Void
    
    var body: some View {
        HStack {
            
            if !firstRun {
                Button(
                    action: backClickEvent,
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
                action: { updateAllEvent(true) },
                label: { Text("Select All").foregroundColor(Color("ColorText")) }
            ).padding(.trailing, 10)
            Button(
                action: { updateAllEvent(false) },
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
            backClickEvent: {},
            updateAllEvent: {_ in }
        ).makeForPreviewProvider()
    }
}
#endif
