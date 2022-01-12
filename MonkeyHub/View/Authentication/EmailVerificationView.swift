//
//  EmailVerificationView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 25.05.2021.
//

import SwiftUI

struct EmailVerificationView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Text("🥳")
                    .font(.system(size: 50, weight: .bold))
                Text("Please check your email to verify your account :) lol haha")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .padding()
                Image(systemName: "envelope.badge")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                Text("Maalesef sayfayı otomatik update edemiyorum henüz çıkıp girmen lazım :)")
                    .foregroundColor(.white)
                    .font(.system(Font.TextStyle.subheadline, design: Font.Design.monospaced))
                    .padding()
                    .border(Color.white)
                    .padding(.top)
                Button(action: {AuthViewModel.shared.signOut()}, label: {
                    Text("Logout")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .clipShape(Capsule())

                })

            }
        }
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerificationView()
    }
}
