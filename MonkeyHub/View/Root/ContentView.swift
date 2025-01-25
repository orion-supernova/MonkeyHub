//
//  ContentView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    @State private var eulaPresent = false

    var body: some View {

        Group {

                // if not logged in show show login

                if viewModel.userSession == nil {

                    LoginView()

                } else {

                    // else logged in already, check is email verified

                    if Auth.auth().currentUser?.isEmailVerified == false {

                        EmailVerificationView()

                    } else if Auth.auth().currentUser?.isEmailVerified == true {

                        if let user = viewModel.currentUserObject {

                            MainTabView(user: user, selectedIndex: $selectedIndex)
                                .onAppear {
                                    let confirmed = AppGlobal.shared.eulaConfirmed ?? false
                                    eulaPresent = !confirmed
                                }
                                .fullScreenCover(isPresented: $eulaPresent, content: {
                                    EULAView()
                                })
                        }
                    }
                }
        }
        .accentColor(.pink)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
