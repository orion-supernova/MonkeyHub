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
        
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(viewmodel.posts, content: { post in
                        FeedCell(viewmodel: FeedCellViewModel(post: post))
                            .padding(.top)
                    })
                }
//                LazyVStack(spacing: 24) {
//                    ForEach(0..<viewmodel.posts.indices.count) { index in
//                        FeedCell(viewmodel: FeedCellViewModel(post: viewmodel.posts[index]), index: index)
//                            .padding(.top)
//                    }
//                }
                
            }
        
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
