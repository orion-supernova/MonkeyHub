    //
    //  FeedView.swift
    //  MonkeyHub
    //
    //  Created by Murat Can KOÇ on 24.05.2021.
    //

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct FeedView: View {

    @ObservedObject var viewmodel = FeedViewModel()
    @State var followingUserCount = 0

    var body: some View {

        if viewmodel.posts.isEmpty {
            Text("No posts yet!")
        } else {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(viewmodel.posts) { post in
                        FeedCell(viewmodel: FeedCellViewModel(post: post))
                            .padding(.top)
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
