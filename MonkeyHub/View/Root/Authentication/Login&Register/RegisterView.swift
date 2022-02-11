//
//  RegisterView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 25.05.2021.
//

import SwiftUI

struct RegisterView: View {

    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var mode

    @State private var selectedImage: UIImage?
    @State  private var profileImage: Image?
    @State var imagePickerPresented = false
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            if viewModel.loadingIndicatorWithSwiftUI ?? false {

               LoaderView2()

            }

            VStack {

                Spacer()

                if profileImage == nil {
                    Button(action: { imagePickerPresented.toggle() }, label: {
                        Image(systemName: "person.badge.plus")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 150)
                            .foregroundColor(.white)
                    })
                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedImage)
                    })

                } else if let image = profileImage {

                    Button(action: { imagePickerPresented.toggle() }, label: {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    })
                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedImage)
                    })
                }

                VStack(spacing: 15) {

                    // email field

                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)

                    // fullname

                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)

                    // username
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)

                    // password field

                    CustomSecureField(text: $password, placeholder: Text("Password "))
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                }

                // sign Up
                Button(action: {

                    if email == "" {
                        Helper.app.alertMessage(title: "Missing Info", message: "Please provide an email")
                    } else if fullname == "" {
                        Helper.app.alertMessage(title: "Missing Info", message: "Please provide a full name")
                    } else if username == "" {
                        Helper.app.alertMessage(title: "Missing Info", message: "Please provide a username")
                    } else if password == "" {
                        Helper.app.alertMessage(title: "Missing Info", message: "Please provide a password")
                    } else if selectedImage == nil {
                        Helper.app.alertMessage(title: "Missing Info", message: "Please provide a profile picture")
                    } else {

                        viewModel.loadingIndicatorWithSwiftUI = true

                        viewModel.register(withEmail: email,
                                           password: password,
                                           image: selectedImage,
                                           fullname: fullname,
                                           username: username)

                    }

                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 45)
                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .clipShape(Capsule())
                        .padding()
                })

                Spacer()
                Spacer()
                Spacer()

                // Already an account? sign in

                HStack {
                    Text("Already an account?")
                        .font(.system(size: 14))

                    Button(action: { mode.wrappedValue.dismiss() }, label: {
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    })
                }
                .foregroundColor(.white)
                .padding(.bottom, 10)

            }
            .zIndex(1)
        }

    }

}

extension RegisterView {
    func loadImage () {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        RegisterView().imagePickerPresented.toggle()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
