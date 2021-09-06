//
//  LottieView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 5.09.2021.
//

import SwiftUI
import Lottie

struct LottieButton: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var animationName: String
    var animationStopped: Bool?
    let animationView = AnimatedButton()
    let action: () -> Void
    
    func makeUIView(context: UIViewRepresentableContext<LottieButton>) -> UIView {
        let view = UIView()
        
        let animation = Animation.named(animationName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieButton>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject {
        let parent: LottieButton
        
        init(_ parent: LottieButton) {
            self.parent = parent
            super.init()
            parent.animationView.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        }
        
        // this function can be called anything, but it is best to make the names clear
        @objc func touchUpInside() {
            parent.action()
        }
    }
    
    
}
