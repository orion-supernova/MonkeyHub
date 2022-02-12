//
//  FeedView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct FeedView: View {

    @ObservedObject var viewmodel = FeedViewModel()

    var body: some View {

        ScrollView(.vertical) {
            LazyVStack(spacing: 24) {
                ForEach(viewmodel.posts) { post in
                    FeedCell(viewmodel: FeedCellViewModel(post: post))
                        .padding(.top)
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
