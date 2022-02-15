//
//  Notification.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 29.05.2021.
//

import FirebaseFirestoreSwift
import Firebase

struct Notification: Identifiable, Decodable {

    @DocumentID var id: String?
    var postID: String?
    let username: String
    let profileImageURL: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String

    var isfollowed: Bool? = false
    var post: Post?
    var user: User?

}

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow

    var notificationMessage: String {
        switch self {
        case .like:
            return " liked one of your posts."
        case .comment:
            return " commented one of your posts."
        case .follow:
            return " started following you."
        }
    }
}
