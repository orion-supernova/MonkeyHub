//
//  NotificationsViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 29.05.2021.
//

import SwiftUI
import Firebase

class NotificationsViewModel: ObservableObject {

    @Published var notifications = [Notification]()

    init() {
        fetchNotifications()
    }

    func fetchNotifications() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }

        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").order(by: "timestamp", descending: true)
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.notifications = documents.compactMap({ try? $0.data(as: Notification.self) })

//            print(self.notifications)
        }
    }

    static func uploadNotification(toUID uid: String, type: NotificationType, post: Post? = nil) {

        guard let user = AuthViewModel.shared.currentUserObject else { return }
        guard  uid != user.id else { return }

        var data = ["timestamp": Timestamp(date: Date()),
                    "username": user.username,
                    "uid": user.id ?? "",
                    "profileImageURL": user.profileImageURL,
                    "type": type.rawValue] as [String: Any]

        if let post = post, let id = post.id {
            data["postID"] = id
        }

        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)

    }

}
