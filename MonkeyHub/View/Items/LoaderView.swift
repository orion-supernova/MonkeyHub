//
//  LoaderView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import SwiftUI

struct LoaderView: View {
    
    @State var animate = false
    
    
    var body: some View {
        
        
            
            VStack {
                Circle()
                    .trim(from: 0.0, to: 1)
                    .stroke(AngularGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), center: .center, angle: .degrees(15)), style: StrokeStyle(lineWidth: 8, lineCap: .butt))
                    .frame(width: 45, height: 45)
                    .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7)
                                .repeatForever(autoreverses: false))
                
            }
            .onAppear {
                self.animate.toggle()
            }
            .zIndex(5)
            
        
        
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
