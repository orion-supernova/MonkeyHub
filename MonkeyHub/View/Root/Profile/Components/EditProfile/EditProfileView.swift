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
    @EnvironmentObject var authViewModel: AuthViewModel

    @State var bioText = ""
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State private var profileImageUIImage: UIImage?
    @State var imagePickerPresented = false
    @State var didTapDoneButton = false

    @State private var willUpdateProfilePicture = false
    @State private var imageURL: String?
    @State private var data = [String: Any]()

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
                            // MARK: - Update Profile Flow
                            guard let user = AuthViewModel.shared.currentUserObject else { return }
                            guard let uid = user.id else { return }
                            if let image = profileImageUIImage {
                                // MARK: - Update with Profile Picture
                                willUpdateProfilePicture = true
                                ImageUploader.uploadImage(image: image, type: .profile) { url in
                                    self.imageURL = url
                                    data = ["bio": bioText, "profileImageURL": url]
                                    viewmodel.user.profileImageURL = url
                                    viewmodel.user.bio = bioText
                                    // MARK: - Continue Flow
                                    COLLECTION_USERS.document(uid).updateData(data) { error in
                                        guard error == nil else { return }
                                    }
                                }
                            } else {
                                // MARK: - Update without Profile Picture
                                willUpdateProfilePicture = false
                                data = ["bio": bioText]
                                viewmodel.user.bio = bioText
                                // MARK: - Continue Flow
                                COLLECTION_USERS.document(uid).updateData(data) { error in
                                    guard error == nil else { return }
                                }
                            }
                            print("saved")
                            mode.wrappedValue.dismiss()
                            didTapDoneButton = false
                            // End of update
                        }), secondaryButton: .cancel(Text("Cancel"), action: {
                            didTapDoneButton = false
                            // Do nothing
                        }))
                    })
            }
            .padding()

            if profileImage == nil {
                Button(action: { imagePickerPresented.toggle() }, label: {
                    KFImage(URL(string: viewmodel.user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading)
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

            CustomTextArea(text: $bioText,
                           placeholder: viewmodel.user.bio == nil ? "Add your bio..." : viewmodel.user.bio!)
                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                .padding()

            Spacer()
        }
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
        profileImageUIImage = selectedImage
    }
}
