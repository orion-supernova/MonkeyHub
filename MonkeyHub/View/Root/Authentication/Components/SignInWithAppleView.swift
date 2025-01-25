//
//  SingInWithAppleView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 1.06.2021.
//

import SwiftUI
import AuthenticationServices
import Firebase
import CryptoKit
import FirebaseAuth


struct SignInWithAppleView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    // from https://firebase.google.com/docs/auth/ios/apple
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    @State var currentNonce: String?

    // Hashing function using CryptoKit
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    var body: some View {

        SignInWithAppleButton(

            // Request
            onRequest: { request in
                let nonce = randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = sha256(nonce)
            },

            // Completion
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:

                        guard let nonce = currentNonce else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let appleIDToken = appleIDCredential.identityToken else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                            return
                        }

                        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                        Auth.auth().signIn(with: credential) { (_, error) in
                            if error != nil {
                                // Error. If error.code == .MissingOrInvalidNonce, make sure
                                // you're sending the SHA256-hashed nonce as a hex string with
                                // your request to Apple.
                                print(error?.localizedDescription as Any)
                                return
                            }
                            print("signed in")

                        }

                        print("\(String(describing: Auth.auth().currentUser?.uid))")
                    default:
                        break

                    }

                default:
                    break
                }

            }
        )
        .signInWithAppleButtonStyle(
//            colorScheme == .dark ? .white : .black
            .white

        )
        .frame(width: 360, height: 45)
        .clipShape(Capsule())
        .padding()

    }

}

struct SingInWithAppleView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView().environmentObject(AuthViewModel())
    }
}

// --------------------------------------------------------------------------------------------------//

// SignInWithAppleButton(.signIn) { request in
//    request.requestedScopes = [.email, .fullName]
// } onCompletion: { result in
//    switch result {
//    case .success(let auth):
//        switch auth.credential {
//        case let credential as ASAuthorizationAppleIDCredential:
//
//            Auth.auth().signIn(with: credential) { authresult, error in
//                if let user = authresult.user {
//
//                }
//            }
//
//        default:
//            break
//        }
//    case .failure(let error):
//        print("error sign in with apple\(error.localizedDescription)")
//        Helper.app.alertMessage(title: "Error", message: error.localizedDescription)
//    }
// }
// .signInWithAppleButtonStyle(
//    colorScheme == .dark ? .white : .black
// )
// .frame(width: 360, height: 50)
// .padding()
// .clipShape(Capsule())
