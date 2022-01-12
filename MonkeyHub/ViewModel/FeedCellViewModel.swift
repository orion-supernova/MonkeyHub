//
//  FeedCellViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {

    @Published var post: Post

    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }

    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }

    func like() {

        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postID = post.id else { return }

        if uid == post.ownerUID {
            Helper.app.alertMessage(title: "Bruuuhhh", message: "Kendi postunu mu beğenicen cidden?.... iyi beğen hadi")
        }

        COLLECTION_POSTS.document(postID).collection("post-likes").document(uid).setData([:]) { error in
            guard error == nil else { print("Failed to like post. \(error!.localizedDescription)"); return }

            COLLECTION_USERS.document(uid).collection("user-likes").document(postID).setData([:]) { _ in

                COLLECTION_POSTS.document(postID).updateData(["likes": self.post.likes+1])

                NotificationsViewModel.uploadNotification(toUID: self.post.ownerUID, type: .like, post: self.post)

                self.post.didLike = true
                self.post.likes += 1
            }

        }

    }

    func unlike() {

        guard post.likes > 0 else { return }

        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postID = post.id else { return }

        if uid == post.ownerUID {
            Helper.app.slangAlertMessage(title: "Noldu?",
                                         message: "Tuhaf olduğunu fark edip unlike mı atmaya karar verdin :)")
        }

        COLLECTION_POSTS.document(postID).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postID).delete { _ in

                COLLECTION_POSTS.document(postID).updateData(["likes": self.post.likes-1])

                self.post.didLike = false
                self.post.likes -= 1
            }
        }

    }

    func checkIfUserLikedPost() {

        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postID = post.id else { return }

        COLLECTION_USERS.document(uid).collection("user-likes").document(postID).getDocument { snapshot, _ in

            guard let didLike = snapshot?.exists else { return }
            self.post.didLike = didLike

        }

    }

}
