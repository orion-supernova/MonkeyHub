//
//  Zoom.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 25.01.2022.
//

import SwiftUI

extension View {
    func addPinchZoom()-> some View {
        return PinchZoomContext {
            self
        }
    }
}

struct PinchZoomContext<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    // Offset and Scale Data
    @State var offset: CGPoint = .zero
    @State var scale: CGFloat = 0

    @State var scalePosition: CGPoint = .zero

    // Creating a SceneStorage that will give whether the Zooming is happening or not
    @SceneStorage("isZooming") var isZooming: Bool = false

    var body: some View {

        content
        // Applying offset before scaling
            .offset(x: offset.x, y: offset.y)
        // Using UIKit Gestures for simultaneously recognize both Pinch and Pan Gesture
            .overlay(
                GeometryReader { proxy in
                    let size = proxy.size

                    ZoomGesture(size: size, scale: $scale, offset: $offset, scalePosition: $scalePosition)
                }
            )
        // Scaling Content
            .scaleEffect(1 + (scale < 0 ? 0 : scale), anchor: .init(x: scalePosition.x, y: scalePosition.y))
        // Puting image at top when zooming
            .zIndex(scale != 0 ? 1000 : 0)
            .onChange(of: scale) { _ in
                isZooming = (scale != 0 && offset != .zero)
                if scale == -1 {
                    // Giving some time to finish amimation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        scale = 0
                    }
                }
            }
    }
}

struct ZoomGesture: UIViewRepresentable {

    // Getting size for calculating scale
    var size: CGSize

    @Binding var scale: CGFloat
    @Binding var offset: CGPoint

    @Binding var scalePosition: CGPoint

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        // Adding Gestures
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))

        panGesture.delegate = context.coordinator
        view.addGestureRecognizer(pinchGesture)
        view.addGestureRecognizer(panGesture)
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }

    // Creating Handlers for Gestures
    class Coordinator: NSObject, UIGestureRecognizerDelegate {

        var parent: ZoomGesture

        init(parent: ZoomGesture) {
            self.parent = parent
        }

        // Making pan to recognize simultaneously
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }

        @objc func handlePan(sender: UIPanGestureRecognizer) {

            // Setting Max Num of Touches
            sender.maximumNumberOfTouches = 2

            // Minimum scale is 1
            if (sender.state == .began || sender.state == .changed) && parent.scale > 0 {
                if let view = sender.view {
                    // Getting translation
                    let translation = sender.translation(in: view)
                    parent.offset = translation
                }
            } else {
                withAnimation {
                    parent.offset = .zero
                    parent.scalePosition = .zero
                }
            }
        }

        @objc func handlePinch(sender: UIPinchGestureRecognizer) {

            // Calculating Scale
            if sender.state == .began || sender.state == .changed {
                // Settings Scale and removing the 1 that already added
                parent.scale = sender.scale - 1

                // Getting the position where the user pinched in order to apply the scale to that point
                let scalePoint = CGPoint(x: sender.location(in: sender.view).x / sender.view!.frame.size.width, y: sender.location(in: sender.view).y / sender.view!.frame.size.height)
                // So that the result will be ((0...1),(0...1))

                // Updating scale point only once
                parent.scalePosition = parent.scalePosition == .zero ? scalePoint : parent.scalePosition
            } else {
                // Settings Scale to 0
                withAnimation(.spring()) {
                    parent.scale = -1
                    parent.scalePosition = .zero
                }
            }
        }
    }
}
