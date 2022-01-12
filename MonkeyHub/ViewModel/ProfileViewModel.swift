//
//  ProfileViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 26.05.2021.
//

import SwiftUI

class ProfileViewModel: ObservableObject {

    @Published var user: User

    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }

    func follow() {

        guard let uid = user.id else { return }

        UserService.follow(uid: uid) { _ in

            NotificationsViewModel.uploadNotification(toUID: uid, type: .follow)
            self.user.isfollowed = true
            print("Successfully followed \(self.user.username)")

        }

    }

    func unfollow() {

        guard let uid = user.id else { return }

        UserService.unfollow(uid: uid) { _ in
            self.user.isfollowed = false
        }

        print("Successfully unfollowed \(self.user.username)")
    }

    func checkIfUserIsFollowed() {

        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }

        UserService.checkIfUserIsFollowed(uid: uid) { isFollowed in
            self.user.isfollowed = isFollowed
        }
    }

    func fetchUserStats() {
        guard let uid = user.id else { return }

        COLLECTION_FOLLOWING.document(uid).collection("user-following").addSnapshotListener { snapshot, error in
            guard let followingCount = snapshot?.documents.count else { print(error!.localizedDescription); return }

            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").addSnapshotListener { snapshot, error in
                guard let followersCount = snapshot?.documents.count else {print(error!.localizedDescription); return }

                COLLECTION_POSTS.whereField("ownerUID", isEqualTo: uid).addSnapshotListener { snapshot, error in
                    guard let postsCount = snapshot?.documents.count else {print(error!.localizedDescription); return }

                    self.user.stats = UserStats(following: followingCount, followers: followersCount, posts: postsCount)

                }
            }
        }

    }

    func fetchBio(completion: @escaping(String) -> Void) {
        guard let uid = user.id else { return }

        COLLECTION_USERS.document(uid).addSnapshotListener {snaphot, _ in

            guard let userDataFromFirestore = try? snaphot?.data(as: User.self) else { return }

            completion(userDataFromFirestore.bio ?? "")

        }
    }

}
