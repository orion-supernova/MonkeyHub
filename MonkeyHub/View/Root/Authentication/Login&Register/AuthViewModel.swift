//
//  AuthViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 25.05.2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    @Published var currentUserObject: User?
    @Published var loadingIndicatorWithSwiftUI: Bool?
    @Published var didSendResetPasswordLink = false

    static let shared = AuthViewModel()

    init() {
        userSession = Auth.auth().currentUser
        fetchUser()

    }

    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.loadingIndicatorWithSwiftUI = false
                Helper.app.alertMessage(title: "Failed", message: error!.localizedDescription)
                print("Failed to sign in \(error!.localizedDescription)")
                return
            }

            guard let user = result?.user else { return }
            self.userSession = user

                if user.isEmailVerified == false {
                    user.sendEmailVerification(completion: { error in
                        if error != nil {
                            print("Failed to send email verification \(error!.localizedDescription)")
                        }
                        print("check email after sign in")
                    })
                } else {
                    print("email already verified")
                }
            self.fetchUser()
            self.loadingIndicatorWithSwiftUI = false
        }

        print("Login")
    }

    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {

        guard let image = image else { return }

        ImageUploader.uploadImage(image: image, type: .profile) { imageURL in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error != nil {

                    self.loadingIndicatorWithSwiftUI = false

                    Helper.app.alertMessage(title: "Failed", message: error!.localizedDescription)
                    print("Failed to create user. \(error!.localizedDescription)")
                    return
                } else {
                    guard let user = result?.user else { return }
                    print("Successfully created user")

                    let data = ["email": email,
                                "username": username,
                                "fullname": fullname,
                                "profileImageURL": imageURL,
                                "uid": user.uid]
                    COLLECTION_USERS.document(user.uid).setData(data) { error in
                        print("Sucessfully uploaded user data!")
                        self.userSession = user

                        if user.isEmailVerified == false {
                            user.sendEmailVerification(completion: { error in
                                if error != nil {
                                    print("Failed to send email verification \(error!.localizedDescription)")
                                }
                                print("check email after registration")
                            })
                        } else {
                            print("email already verified")
                        }
                        self.fetchUser()
                        self.loadingIndicatorWithSwiftUI = false
                    }
                }
            }
        }
    }

    func resetPassword(withEmail email: String) {

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to send reset  password link. \(error.localizedDescription)")
                Helper.app.alertMessage(title: "Error", message: error.localizedDescription)
                return
            }

            self.didSendResetPasswordLink = true

            Helper.app.alertMessage(title: "Done", message: "You can check your email to reset your password!")

            print("Successfully sent password reset email with email \(email)")
        }
    }

    func signOut() {
        self.userSession = nil

        try? Auth.auth().signOut()
        self.loadingIndicatorWithSwiftUI = false
        print("logout")
    }

    func fetchUser() {

        guard let userUID = userSession?.uid  else { return }

        COLLECTION_USERS.document(userUID).getDocument { snapshot, _ in

            guard let userDataFromFirestore = try? snapshot?.data(as: User.self) else { return }

            self.currentUserObject = userDataFromFirestore

        }

    }

}
