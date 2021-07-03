//
//  PostGridView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Kingfisher


struct PostGridView: View {
    

    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    let config: PostGridConfiguration
    
    @ObservedObject var viewmodel: PostGridViewModel


    init(config: PostGridConfiguration) {
        self.config = config
        self.viewmodel = PostGridViewModel(config: config)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(viewmodel.posts) { post in
                NavigationLink(
                    destination: FeedCell(viewmodel: FeedCellViewModel(post: post)),
                    label: {
                        KFImage(URL(string: post.imageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width)
                            .clipped()
                    })
            }
        })
    }
}

//struct PostGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostGridView(viewmodel: PostGridViewModel())
//    }
//}
