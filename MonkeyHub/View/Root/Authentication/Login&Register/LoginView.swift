//
//  LoginView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 25.05.2021.
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

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

                        // MARK: - Email Field
                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)

                        // MARK: - Password Field
                        CustomSecureField(text: $password, placeholder: Text("Password "))
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    }

                    // MARK: - Forgot Password
                    HStack {
                        Spacer()

                        NavigationLink(
                            destination: ResetPasswordView(email: $email),
                            label: {
                                Text("Forgot Password?")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.top)
                                    .padding(.trailing, 28)
                            })

                    }

                    // MARK: - Sign In
                    Button(action: {
                        viewModel.loadingIndicatorWithSwiftUI = true

                        viewModel.login(withEmail: email, password: password)

                    }, label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                            .clipShape(Capsule())
                            .padding()
                    })

//                    SignInWithAppleView()

                    Spacer()

                    // MARK: - Don't have an account? Sign Up
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 14))

                        NavigationLink(
                            destination: RegisterView()
                                .navigationBarHidden(true),
                            label: {
                                Text("Sign Up")
                                    .font(.system(size: 14, weight: .semibold))
                            })

                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                }
            }
            .navigationBarHidden(true)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
