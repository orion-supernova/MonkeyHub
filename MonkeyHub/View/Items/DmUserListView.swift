//
//  DmUserListView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI

struct DmUserListView: View {
    
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
//                            DirectConversationView(dmConversation: user)
//                                .padding(.leading)
                        })
                        .foregroundColor(.black)
                }
            }
        }
    }
}


//struct DmUserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DmUserListView()
//    }
//}
