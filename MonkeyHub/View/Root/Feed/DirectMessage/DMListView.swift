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
    @State private var navTitleEnabled = true

    var users: [User] {
        return searchTextBinding.isEmpty ? viewModel.users : viewModel.filteredUsers(query: searchTextBinding)
    }
    var dmConversations = [ChatRoom]()
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink {
                        ChatRoomView(chatRoom: ChatRoom(id: "1234", ownersUID: "1234", timestamp: Timestamp(date: Date())))
                    } label: {
                        UserCell(user: user)
                            .padding(.leading)
                    }
                    .navigationBarTitle("") // Bir sonraki sayfaya geçince backButtondaki texti kaldırmak için
                }
            }
        }
        .padding()
    }
}

 struct DMListView_Previews: PreviewProvider {
    static var previews: some View {
        DMListView(dmViewModel: DMViewModel(chatRoom: ChatRoom(id: "", ownersUID: "", timestamp: Timestamp(date: Date()))), searchTextBinding: .constant(""))
    }
 }
