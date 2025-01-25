//
//  CommentViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {

    private let post: Post
    @Published var comments = [Comment]()

    init(post: Post) {
        self.post = post
        fetchComments()
    }

    func uploadComment(commentText: String) {

        guard let user = AuthViewModel.shared.currentUserObject else { return }
        guard let postId = post.id else { return }

        let data = ["username": user.username,
                    "profileImageURL": user.profileImageURL,
                    "uid": user.id ?? "",
                    "timestamp": Timestamp(date: Date()),
                    "postOwnerUID": post.ownerUID,
                    "commentText": commentText] as [String: Any]

        let document = COLLECTION_POSTS.document(postId)
        document.collection("post-comments").addDocument(data: data) { error in
            if error != nil {
                Helper.app.alertMessage(title: "Error", message: error!.localizedDescription)
                print("Failed to upload comment. \(error!.localizedDescription)")
            }
            var ownerToken = ""
            var postDict: [String: Any]?

            document.getDocument { snapshot, error in
                guard error == nil, let snapshot = snapshot else { return }
                postDict = snapshot.data()

                guard let post = postDict else {
                    return
                }
                ownerToken = post["ownerFcmToken"] as? String ?? ""

                // Sending push notification to the related user.
                NotificationsViewModel.uploadNotification(toUID: self.post.ownerUID, type: .comment, post: self.post)
                let sender = PushNotificationSender()
                sender.sendPushNotification(to: ownerToken, title: "MonkeyHub", body: "\(user.username) commented one of your posts.")
            }
        }

    }

    func fetchComments() {
        guard let postId = post.id else { return }

        let query = COLLECTION_POSTS.document(postId).collection("post-comments").order(by: "timestamp",
                                                                                        descending: false)

        query.addSnapshotListener { snapshot, _ in

            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            self.comments.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: Comment.self) }))
        }

    }

}
