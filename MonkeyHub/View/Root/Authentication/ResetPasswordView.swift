//
//  ResetPasswordView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 25.05.2021.
//

import SwiftUI

struct ResetPasswordView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var mode

    @Binding private var email: String

    init(email: Binding<String>) {
        self._email = email
    }

    var body: some View {

        NavigationView {
            ZStack(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                if viewModel.loadingIndicatorWithSwiftUI ?? false {

                    LoaderView2()

                }

                VStack {
                    Spacer()
                        .frame(width: getRect().width, height: getRect().height*0.1)
                    Image("monkey")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                        .padding(.top, -50)

                    Text("Monkey Hub")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .semibold, design: Font.Design.rounded))
                        .padding(.bottom, 10)

                    VStack(spacing: 15) {
                        // email field

                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)

                    }

                    Button(action: {

                        viewModel.resetPassword(withEmail: email)

                    }, label: {
                        Text("Send Reset Password Link")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                            .clipShape(Capsule())
                            .padding()
                    })

                    Spacer()
                    Spacer()
                    Spacer()

                    // Already an account? sign in

                    HStack {
                        Text("Remember your password?")
                            .font(.system(size: 14))

                        Button(action: { mode.wrappedValue.dismiss() }, label: {
                            Text("Sign In")
                                .font(.system(size: 14, weight: .semibold))
                        })
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                }
            }
            .navigationBarHidden(true)
        }
        .onReceive(viewModel.$didSendResetPasswordLink, perform: { _ in
            self.mode.wrappedValue.dismiss()
        })
        .navigationBarHidden(true)

    }

}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
