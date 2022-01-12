//
//  EditProfileView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 29.05.2021.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {

    @ObservedObject var viewmodel: ProfileViewModel

    @State var bioText = ""
    @State private var selectedImage: UIImage?
    @State  private var profileImage: Image?
    @State var imagePickerPresented = false
    @State var didTapDoneButton = false

    @Environment(\.presentationMode) var mode

    var body: some View {

        VStack {

            HStack {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.pink)

                })

                Spacer()
                Button(action: {
                    didTapDoneButton = true
                }, label: {
                    Text("Done")
                        .foregroundColor(.pink)
                        .bold()

                })
                .alert(isPresented: $didTapDoneButton, content: {
                    Alert(title: Text("Save?"),
                          message: Text("Dou you want to save the current info?"),
                          primaryButton: .default(Text("Save"), action: {
                            guard let user = AuthViewModel.shared.currentUserObject else { return }
                            guard let uid = user.id else { return }
                            let data = ["bio": bioText]

                            COLLECTION_USERS.document(uid).updateData(data) { error in
                                guard error == nil else { return }

                                DispatchQueue.main.async {
                                    viewmodel.fetchBio { str in
                                        self.bioText = str
                                        print(bioText)
                                    }
                                }

                            }
                            print("saved")
                            mode.wrappedValue.dismiss()
                            didTapDoneButton = false
                          }), secondaryButton: .cancel(Text("Cancel"), action: {
                            didTapDoneButton = false
                          }))
                })
            }
            .padding()

//            if viewmodel.user.profileImageURL == "" {
//                Button(action: { imagePickerPresented.toggle() }, label: {
//                    Image(systemName: "person.badge.plus")
//                        .renderingMode(.template)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: 100)
//                        .foregroundColor(.pink)
//                })
//                .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
//                    ImagePicker(image: $selectedImage)
//                })
//                
//            }
//            else {
                    KFImage(URL(string: viewmodel.user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading)
//                }

            CustomTextArea(text: $bioText,
                           placeholder: viewmodel.user.bio == nil ? "Add your bio..." : viewmodel.user.bio!)
                    .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                    .padding()

                Spacer()
            }
        .navigationBarHidden(true)

        }
    }

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(viewmodel: ProfileViewModel(user: User(username: "",
                                                               email: "",
                                                               profileImageURL: "",
                                                               fullname: "")))
    }
}

extension EditProfileView {
    func loadImage () {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        RegisterView().imagePickerPresented.toggle()
    }
}
