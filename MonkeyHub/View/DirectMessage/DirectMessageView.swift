//
//  DirectMessageView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI
import Firebase

struct DirectMessageView: View {
    
    @ObservedObject var viewModel = SearchViewModel()
    @ObservedObject var dmViewModel: DirectMessageViewModel
    @Binding var searchTextBinding: String
    
    var users: [User] {
        return searchTextBinding.isEmpty ? viewModel.users : viewModel.filteredUsers(query: searchTextBinding)
    }
    var dmConversations = [DmConversation]()
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink(
                        destination: DirectConversationView(dmConversation: DmConversation.init(ownerUID: "hm", ownerUsername: "hm", ownerImageURL: "hm", caption: "hm", likes: 2, imageURL: "hm", timestamp: Timestamp.init())),
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

//struct DirectMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectMessageView()
//    }
//}
