//
//  IndicatorView.swift
//  CurrencyConverterCalculator
//
//  Created by Mustafa Ozhan on 11/08/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct IndicatorView: View {
    @State private var size = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            InnerView(
                style: .large,
                parentSize: geometry.size,
                size: self.$size
            )
        }.frame(height: size.height)
    }
    
    struct InnerView: UIViewRepresentable {
        let style: UIActivityIndicatorView.Style
        let parentSize: CGSize
        @Binding var size: CGSize
        
        func makeUIView(context _: Context) -> UIActivityIndicatorView {
            let uiView = UIActivityIndicatorView(style: style)
            uiView.startAnimating()
            return uiView
        }
        
        func updateUIView(
            _ uiView: UIActivityIndicatorView,
            context _: Context
        ) {
            DispatchQueue.main.async {
                self.size = uiView.sizeThatFits(self.parentSize)
            }
        }
    }
}

#if DEBUG
struct IndicatorViewPreviews: PreviewProvider {
    
    static var previews: some View {
        IndicatorView()
    }
}
#endif
