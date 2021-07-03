//
//  MainTabView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    @Binding var selectedIndex: Int
    

    
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
                .navigationBarItems(leading: logoutButton)
                .accentColor(.pink)
            }
        
    }
    
    var logoutButton: some View {
        Button {
            AuthViewModel.shared.signOut()
        } label: {
            Text("logout")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.pink)
                .clipShape(Capsule())
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

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView(user: User)
//    }
//}
