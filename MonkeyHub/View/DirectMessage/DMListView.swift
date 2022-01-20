//
//  DirectMessageView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI
import Firebase

struct DMListView: View {

    @ObservedObject var viewModel = SearchViewModel()
    @ObservedObject var dmViewModel: DMViewModel
    @Binding var searchTextBinding: String

    var users: [User] {
        return searchTextBinding.isEmpty ? viewModel.users : viewModel.filteredUsers(query: searchTextBinding)
    }
    var dmConversations = [ChatRoom]()
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink {
                        Text("DM EKRANI")
                    } label: {
                        UserCell(user: user)
                            .padding(.leading)
                    }
                }
            }
        }
    }
}

// struct DMListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectMessageView()
//    }
// }
