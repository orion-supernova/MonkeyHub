//
//  ProfileView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct ProfileView: View {

    let user: User
    @ObservedObject var viewmodel: ProfileViewModel

    init(user: User) {
        self.user = user
        self.viewmodel = ProfileViewModel(user: user)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProfileHeaderView(viewmodel: viewmodel)

                PostGridView(config: .profile(user.id ?? ""))
            }.padding(.top)
        }
    }
}

 struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(username: "", email: "", profileImageURL: "", fullname: ""))
    }
 }
