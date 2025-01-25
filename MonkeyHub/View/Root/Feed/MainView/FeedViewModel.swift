//
//  FeedViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 27.05.2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()

    init() {
//        fetchPosts()
        fetchFollowedUsersPosts()
    }

    func fetchPosts() {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)  })
            print("FeedViewModel fetch post sucessfull!")
        }
    }
    func fetchFollowedUsersPosts() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        let followingRef = Firestore.firestore().collection("following").document(currentUserID).collection("user-following")
        followingRef.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error fetching followed users: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else { return }

            let followedUserIDs = documents.map { $0.documentID }
            COLLECTION_POSTS.whereField("ownerUID", in: followedUserIDs)
                .order(by: "timestamp", descending: true)
                .addSnapshotListener { snapshot, error in
                    guard error == nil else { print(error!.localizedDescription); return }
                    guard let documents = snapshot?.documents else { return }
                    self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
                    print("FeedViewModel fetch followed users' posts successful!")
            }
        }
    }
}
