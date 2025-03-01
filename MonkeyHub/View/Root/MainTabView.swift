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
    @Environment(\.openURL) var openURL

    var body: some View {

        NavigationView {
            TabView(selection: $selectedIndex) {
                LazyView(FeedView())
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
            Helper.app.alertMessageWithCompletion(title: "Logout", message: "Do you want to logout?") { success in
                if success {
                    AuthViewModel.shared.signOut()
                }
            }
        } label: {
            Text("logout")
                .font(.system(size: 15, weight: .regular))
                .clipShape(Capsule())
        }

    }
    var dmButton: some View {
        Button {
            if let url = URL(string: "https://apps.apple.com/us/app/monkeychat-a-monkeyhub-project/id1610516543") {
                openURL(url)
            }
        } label: {
            Image(systemName: "paperplane")
        }
//        NavigationLink(
//            destination: DMListView(dmViewModel: DMViewModel(chatRoom: ChatRoom(id: "1234", ownersUID: "1234", timestamp: Timestamp(date: Date()))), searchTextBinding: $searchText),
//            label: {
//            })
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

 struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: User(username: "", email: "", profileImageURL: "", fullname: ""), selectedIndex: .constant(0), searchText: "")
    }
 }
