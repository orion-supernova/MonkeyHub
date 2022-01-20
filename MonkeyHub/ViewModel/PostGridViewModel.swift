//
//  PostGridViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 27.05.2021.
//

import SwiftUI

enum PostGridConfiguration {
    case explore
    case profile(String)
}

class PostGridViewModel: ObservableObject {

    @Published var posts = [Post]()
//    let config: PostGridConfiguration

    init(config: PostGridConfiguration) {
//        self.config = config
        fetchPosts(forConfig: config)
    }

    func fetchPosts(forConfig config: PostGridConfiguration) {
        switch config {
        case .explore:
            fetchExplorePagePosts()
        case .profile(let uid):
            fetchUserProfilePosts(forUID: uid)
        }
    }

    func fetchUserProfilePosts(forUID uid: String) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true)
            .whereField("ownerUID", isEqualTo: uid).getDocuments { snapshot, error in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)  })
            print("fetch user profile post sucessfull!")
        }
    }

    func fetchExplorePagePosts() {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)  })
            print("fetch explore post sucessfull!")
        }
    }
}
