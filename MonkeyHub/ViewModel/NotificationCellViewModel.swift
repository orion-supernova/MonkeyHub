//
//  NotificationCellViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 29.05.2021.
//

import SwiftUI

class NotificationCellViewModel: ObservableObject {
    
    @Published var notification: Notification
    
    
    init(notification: Notification) {
        self.notification = notification
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    func follow() {
        
        
        UserService.follow(uid: notification.uid) { _ in
            NotificationsViewModel.uploadNotification(toUID: self.notification.uid, type: .follow)
            
            self.notification.isfollowed = true
            
            print("Successfully followed \(self.notification.username)")

        }
    }
    
    func unfollow() {
        
        
        UserService.unfollow(uid: notification.uid) { _ in
            
            self.notification.isfollowed = false
        }
        
        print("Successfully unfollowed \(self.notification.username)")
    }
    
    func checkIfUserIsFollowed() {
        
        guard notification.type == .follow else { return }
        
        UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
            self.notification.isfollowed = isFollowed
        }
    }
    
    
    func fetchNotificationPost() {
        
        guard let postID = notification.postID else { return }
        
        COLLECTION_POSTS.document(postID).getDocument { snapshot, _ in
            self.notification.post = try? snapshot?.data(as: Post.self)
        }
    }
    
    func fetchNotificationUser() {
        COLLECTION_USERS.document(notification.uid).getDocument { snapshot, _ in
            self.notification.user = try? snapshot?.data(as: User.self)
//            print("User is \(self.notification.user?.username)")
        }
    }
    
    
}
