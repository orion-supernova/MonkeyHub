//
//  LottieView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 5.09.2021.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    typealias UIViewType = UIView
    var animationName: String
    var animationStopped: Bool?
    let animationView = AnimatedButton()
//    let action: () -> Void

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = AnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {

    }

    func makeCoordinator() -> Coordinator {
           Coordinator(self)
       }

       class Coordinator: NSObject {
           let parent: LottieView

           init(_ parent: LottieView) {
               self.parent = parent
               super.init()
//               parent.animationView.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
           }

           // this function can be called anything, but it is best to make the names clear
//           @objc func touchUpInside() {
//               parent.action()
//           }
       }

}
