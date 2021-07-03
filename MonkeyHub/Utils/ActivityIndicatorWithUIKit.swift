//
//  ActivityIndicatorWithUIKit.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import SwiftUI

struct ActivityIndicatorWithUIKit: UIViewRepresentable {
    // Code will go here
    
    @Binding var shouldAnimate: Bool
    
    
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        // Create UIActivityIndicatorView
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        // Start and stop UIActivityIndicatorView animation
        
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
    
    
}
