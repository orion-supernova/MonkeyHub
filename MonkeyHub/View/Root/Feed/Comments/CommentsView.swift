//
//  CommentView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import SwiftUI

struct CommentsView: View {

    @State var commentText = ""
    @ObservedObject var viewmodel: CommentViewModel

    init(post: Post) {
        self.viewmodel = CommentViewModel(post: post)
    }

    var body: some View {
        VStack {
            // MARK: - Comment Cells
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewmodel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }
            .padding(.top)

            // MARK: - Message Input View
            KeyboardInputView(text: $commentText, action: uploadComment)

        }
        .navigationTitle("Comments")
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    func uploadComment() {
        viewmodel.uploadComment(commentText: commentText)
        commentText = ""
    }

}

// struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsView(post: post)
//    }
// }
