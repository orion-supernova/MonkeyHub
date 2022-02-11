//
//  FeedViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 27.05.2021.
//

import SwiftUI

class FeedViewModel: ObservableObject {

    @Published var posts = [Post]()

    init() {
        fetchPosts()
    }

    func fetchPosts() {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)  })
            print("fetch post sucessfull!")
        }
    }
}
