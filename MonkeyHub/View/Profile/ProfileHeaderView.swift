//
//  ProfileHeaderView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {

    @ObservedObject var viewmodel: ProfileViewModel

    var body: some View {
        VStack(alignment: .leading) {

            HStack {
                KFImage(URL(string: viewmodel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)

                Spacer()

                HStack(spacing: 20) {

                    UserStatView(value: viewmodel.user.stats?.posts ?? 0, title: "Posts")
                    UserStatView(value: viewmodel.user.stats?.followers ?? 0, title: "Followers")
                    UserStatView(value: viewmodel.user.stats?.following ?? 0, title: "Following")

                }

                Spacer()

            }

            Text(viewmodel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])

            Text(viewmodel.user.bio ?? "")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 1)

            HStack {
                Spacer()

                ProfileActionButtonView(viewmodel: viewmodel)

                Spacer()
            }
            .padding(.top)

        }
    }
}

// struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//    }
// }
