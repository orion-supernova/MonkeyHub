//
//  UploadPostView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Lottie

struct UploadPostView: View {

    @State private var selectedImage: UIImage?
    @State  var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @ObservedObject var viewmodel = PostViewModel()
    @Binding var tabIndex: Int

    @State var isShareButtonHidden = false
    @State var loadingIndicator = false

    var body: some View {

        ZStack {
            if self.loadingIndicator {
               LoaderView2()
            }

            VStack {

                if postImage == nil {
                    VStack {
                        Spacer()

//                        Button(action: { imagePickerPresented.toggle() }, label: {
//                            LottieView(animationName: "uploadAnimation2JSON")
//                                .scaledToFit()
//                                .frame(width: 200, height: 200)
//                                .clipped()
//                                .padding()
//                        })
//                        .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
//                            ImagePicker(image: $selectedImage)
//                        })

//                                     - MARK: Old Button Before LottieView -

                        Button(action: { imagePickerPresented.toggle() }, label: {
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipped()
                                .padding()
                            //                                .foregroundColor(.pink)
                        })
                        .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedImage)
                        })

                        Spacer()
                    }

                } else if let image = postImage {
                    VStack {
                        Spacer()
                        VStack {

                            Button(action: { imagePickerPresented.toggle() }, label: {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 440)
                                    .clipped()
                            })
                            .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                                ImagePicker(image: $selectedImage)
                            })

                            CustomTextArea(text: $captionText, placeholder: "Enter your caption...")
                                .frame(height: 100)

                            HStack {
                                Button(action: {
                                    captionText = ""
                                    postImage = nil
                                }, label: {
                                    Text("Cancel")
                                        .font(.system(size: 16, weight: .light, design: .monospaced))
                                        .frame(width: 172, height: 50)
                                        .background(Color(.systemPink))
                                        .cornerRadius(5)
                                        .foregroundColor(.white)
                                })

                                Button(action: {
                                    self.isShareButtonHidden.toggle()
                                    self.loadingIndicator.toggle()
                                    if let image = selectedImage {
                                        viewmodel.uploadPost(caption: captionText, image: image) { error in
                                            guard error == nil else { print(error!.localizedDescription); return }

                                            isShareButtonHidden.toggle()
                                            self.loadingIndicator.toggle()

                                            captionText = ""
                                            postImage = nil
                                            tabIndex = 0

                                        }
                                    }
                                }, label: {
                                    Text("Share")
                                        .font(.system(size: 16, weight: .semibold))
                                        .frame(width: 172, height: 50)
                                        .background(Color(.systemPink))
                                        .cornerRadius(5)
                                        .foregroundColor(.white)
                                })
                                .opacity(isShareButtonHidden ? 0 : 1)

                            }
                            .padding(.top)

                        }

                        Spacer()
                    }

                }

                Spacer()
            }
            .zIndex(1)
        }
    }

}

extension UploadPostView {
    func loadImage () {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
        RegisterView().imagePickerPresented.toggle()
    }

}

// struct UploadPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadPostView()
//    }
// }
