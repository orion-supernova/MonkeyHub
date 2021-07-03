//
//  NotificationCell.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    
    @State private var showPostImage = false
    
    @ObservedObject var viewmodel: NotificationCellViewModel
    
    var isFollowed: Bool { return viewmodel.notification.isfollowed ?? false }
    
    init(viewmodel: NotificationCellViewModel) {
        self.viewmodel = viewmodel
    }
    
    var body: some View {
        HStack {
            if let user = viewmodel.notification.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    KFImage(URL(string: viewmodel.notification.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .cornerRadius(24)
                    
                    Text(viewmodel.notification.username)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.primary) +
                        Text(viewmodel.notification.type.notificationMessage)
                        .font(.system(size: 14))
                        .foregroundColor(.primary) +
                        Text(" \(viewmodel.timestampString)")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            Spacer()
            Spacer()
            

                if viewmodel.notification.type != .follow {
                    if let post = viewmodel.notification.post {
                        NavigationLink(destination: FeedCell(viewmodel: FeedCellViewModel(post: post))) {
                            KFImage(URL(string: post.imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipped()
                        }
                    }
                } else {
                    Button(action: { isFollowed ? viewmodel.unfollow() : viewmodel.follow() }, label: {
                        Text(isFollowed ? "Following" : "Follow")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 100, height: 32)
                            .foregroundColor(isFollowed ? .pink : .white)
                            .background(isFollowed ? Color(.systemBackground) : Color(.systemPink))
                            .cornerRadius(3)
                            .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(.systemPink), lineWidth: 1)
                            )
                    })
//                    Button (action: {}, label: {
//                        Text("Follow")
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 8)
//                            .background(Color(.systemPink))
//                            .foregroundColor(.white)
//                            .clipShape(Capsule())
//                            .font(.system(size: 14, weight: .semibold))
//                    })
                    
                }

            
            
        }
        .padding(.horizontal)
    }
}

//struct NotificationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationCell()
//    }
//}
