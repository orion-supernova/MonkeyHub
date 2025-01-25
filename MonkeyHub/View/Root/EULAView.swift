//
//  EULAView.swift
//  MonkeyHub
//
//  Created by muratcankoc on 06/08/2024.
//

import SwiftUI
import WebKit

struct EULAView: View {
    @State private var isAgreed = false
    @State private var showAlert = false
    @State private var webViewURL: URL?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            WebView(url: $webViewURL)
                .frame(height: UIScreen.main.bounds.height / 2)

            HStack {
                Button(action: {
                    isAgreed.toggle()
                }) {
                    Image(systemName: isAgreed ? "checkmark.square" : "square")
                        .foregroundColor(.primary)
                }

                Text("I agree to your End User License Agreement.")
                    .font(.system(size: 14))
            }
            .padding()

            Button("Continue") {
                if isAgreed {
                    AppGlobal.shared.eulaConfirmed = true
                    presentationMode.wrappedValue.dismiss()
                    // You would typically handle navigation to the main app view here
                } else {
                    showAlert = true
                }
            }
            .font(.system(size: 14))
            .foregroundColor(.pink)
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Not agreed"),
                message: Text("You need to agree to our license in order to use the app."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            loadWebViewURL()
        }
    }

    private func loadWebViewURL() {
//        // Assuming you're using Firebase, you might want to use a different method to fetch the URL
//        // This is a placeholder for the Firebase fetch operation
//        COLLECTION_WEBLINKS.document("weblinks").getDocument { snapshot, error in
//            guard let snapshot = snapshot, error == nil,
//                  let dict = snapshot.data(),
//                  let urlString = dict["eula"] as? String,
//                  let url = URL(string: urlString) else { return }
//
//            self.webViewURL = url
//        }
        self.webViewURL = URL(string: "https://muratcankoc.wixsite.com/ammckproductions/monkeyhub-eula")
    }
}

struct WebView: UIViewRepresentable {
    @Binding var url: URL?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            uiView.load(URLRequest(url: url))
        }
    }
}
