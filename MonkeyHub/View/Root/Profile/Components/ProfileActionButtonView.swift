//
//  ProfileActionButtonView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewmodel: ProfileViewModel
    @State var showEditProfile = false
    var isFollowed: Bool { return viewmodel.user.isfollowed ?? false}

    var body: some View {
        if viewmodel.user.isCurrentUser {

            // MARK: - Edit profile button
            Button {
                withAnimation {
                    showEditProfile.toggle()
                }
            } label: {
                Text("Edit Profile")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: getRect().width, height: 32)
                    .foregroundColor(.pink)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color(.systemPink), lineWidth: 1)
                    )
            }
            .fullScreenCover(isPresented: $showEditProfile) {
                EditProfileView(viewmodel: ProfileViewModel(user: viewmodel.user))
            }

        } else {

            // MARK: - Follow and message button
            HStack {
                Button(action: { isFollowed ? viewmodel.unfollow() : viewmodel.follow() }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(isFollowed ? .pink : .white)
                        .background(isFollowed ? Color(.systemBackground) : Color(.systemPink))
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(.systemPink), lineWidth: 1)
                        )
                })

                Button(action: {}, label: {
                    Text("Message")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(.pink)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(.systemPink), lineWidth: 1)
                        )
                })
            }
        }
    }
}

 struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView(viewmodel: ProfileViewModel(user: User(username: "", email: "", profileImageURL: "", fullname: "")))
    }
 }
