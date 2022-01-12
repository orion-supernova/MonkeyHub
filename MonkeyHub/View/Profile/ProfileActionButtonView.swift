//
//  ProfileActionButtonView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct ProfileActionButtonView: View {

    @ObservedObject var viewmodel: ProfileViewModel
    var isFollowed: Bool { return viewmodel.user.isfollowed ?? false}
    @State var showEditProfile = false
    var body: some View {
        if viewmodel.user.isCurrentUser {

            // edit profile button

            NavigationLink(
                destination: EditProfileView(viewmodel: ProfileViewModel(user: viewmodel.user)),
                label: {
                    Text("Edit Profile Button1")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 180, height: 32)
                        .foregroundColor(.pink)
                        .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color(.systemPink), lineWidth: 1)
                        )
                })
            Button(action: { showEditProfile.toggle() }, label: {
                Text("Edit Profile Button2")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 180, height: 32)
                    .foregroundColor(.pink)
                    .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(.systemPink), lineWidth: 1)
                    )
            })
            .sheet(isPresented: $showEditProfile, content: {
                EditProfileView(viewmodel: ProfileViewModel(user: viewmodel.user))
            })

        } else {

            // follow and message button

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

// struct ProfileActionButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileActionButtonView()
//    }
// }
