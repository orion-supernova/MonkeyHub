//
//  UserListView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct UserListView: View {

    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchTextBinding: String

    var users: [User] {
        return searchTextBinding.isEmpty ? viewModel.users : viewModel.filteredUsers(query: searchTextBinding)
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink(
                        destination: LazyView(ProfileView(user: user)),
                        label: {
                            UserCell(user: user)
                                .padding(.leading)
                        })
                        .foregroundColor(.black)
                }
            }
        }
    }
}

//
// struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
// }
