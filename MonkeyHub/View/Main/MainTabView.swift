//
//  MainTabView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Firebase

struct MainTabView: View {

    let user: User
    @Binding var selectedIndex: Int

    @State var searchText = ""

    var body: some View {

        NavigationView {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)

                LazyView(SearchView())
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle")
                    }.tag(1)

                LazyView(UploadPostView(tabIndex: $selectedIndex))
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "plus.circle")
                    }.tag(2)

                LazyView(NotificationsView())
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "heart.circle")
                    }.tag(3)

                LazyView(ProfileView(user: user))
                    .onTapGesture {
                        selectedIndex = 4
                    }
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(4)
            }
            .navigationTitle(tabTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: logoutButton, trailing: selectedIndex == 4 ? AnyView(settingsButton) : AnyView(dmButton))
        }

    }

    var logoutButton: some View {
        Button {
            AuthViewModel.shared.signOut()
        } label: {
            Text("logout")
                .font(.system(size: 15, weight: .regular))
                .clipShape(Capsule())
        }

    }
    var dmButton: some View {
        NavigationLink(
            destination: DirectMessageView(dmViewModel:
                                            DirectMessageViewModel(dmConversation:
                                                                    DmConversation.init(id: "hm",
                                                                                        ownerUID: "hm",
                                                                                        ownerUsername: "hm",
                                                                                        ownerImageURL: "hm",
                                                                                        caption: "hm",
                                                                                        likes: 0,
                                                                                        imageURL: "hm",
                                                                                        timestamp: Timestamp.init(),
                                                                                        didLike: false)),
                                                                                        searchTextBinding: $searchText),
            label: {
                Image(systemName: "paperplane")
                    .foregroundColor(.pink)
            })
    }
    var settingsButton: some View {
        Button {
            Helper.app.alertMessage(title: "Token copied to clipboard", message: Helper.app.APNS_Token)
            UIPasteboard.general.string = Helper.app.APNS_Token
        } label: {
            Image(systemName: "gearshape")
        }
    }

    var tabTitle: String {

        switch selectedIndex {
        case 0:
            return "Feed"
        case 1:
            return "Explore"
        case 2:
            return "New Post"
        case 3:
            return "Notifications"
        case 4:
            return "Profile"
        default:
            return ""
        }

    }

}

// struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView(user: User)
//    }
// }
