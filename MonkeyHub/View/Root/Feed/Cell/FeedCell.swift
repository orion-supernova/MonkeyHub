//
//  FeedCell.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {

    @ObservedObject var viewmodel: FeedCellViewModel
    @ObservedObject var userlistviewmodel = SearchViewModel()

    @State var likeAnimationHeart = false

    var users: [User] {
        userlistviewmodel.users
    }

    var didLike: Bool { return viewmodel.post.didLike ?? false }

    init(viewmodel: FeedCellViewModel) {
        self.viewmodel = viewmodel
    }

    var body: some View {
        VStack(alignment: .leading) {

            // MARK: - User Info
            HStack {
                KFImage(URL(string: viewmodel.post.ownerImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)

                NavigationLink(destination: ProfileView(user: User(username: "Hm",
                                                                   email: "Hehe",
                                                                   profileImageURL: "Lol",
                                                                   fullname: "Yapcaz bi şeyler ama üşengeçlik işte"))) {
                    Text(viewmodel.post.ownerUsername)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }

                Spacer()

                // MARK: - Delete Button
                if viewmodel.post.ownerUID == AuthViewModel.shared.userSession?.uid {
                    Button(action: {
                        PostViewModel().removePost(documentID: viewmodel.post.id!,
                                                   imageURL: viewmodel.post.imageURL ) { error in
                            guard error == nil else { print("Delete post button error. \(error!.localizedDescription)"); return }
                            print("post deletion successfull!")

                        }

                    }, label: {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.pink)
                    })
                        .padding(.trailing, 10)
                }
            }
            .padding([.leading, .bottom], 8)

            // MARK: - Post Image
            HStack {
                KFImage(URL(string: viewmodel.post.imageURL))
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 440)
                    .clipped()
                    .gesture(
                        TapGesture(count: 2)
                            .onEnded({ _ in
                                if didLike == false {
                                    viewmodel.like()
                                }
                                self.likeAnimationHeart = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.likeAnimationHeart = false
                                }
                            })
                    )
                    .addPinchZoom()

                if likeAnimationHeart {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                        .clipped()
                        .foregroundColor(.pink)
                }
            }
            .zIndex(1)

            // MARK: - Action Buttons
            HStack(spacing: 16) {

                // like button
                Button(action: {
                    if didLike {
                        viewmodel.unlike()

                    } else {
                        viewmodel.like()
                        self.likeAnimationHeart = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.likeAnimationHeart = false
                        }
                    }

                }, label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })

                // MARK: - Comment Button
                NavigationLink(
                    destination: CommentsView(post: viewmodel.post),
                    label: {
                        Image(systemName: "ellipsis.bubble")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .padding(4)
                    })

                // MARK: - Send Button
                Button(action: {}, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
            }
            .foregroundColor(.pink)

            // MARK: - Caption
            Text("\(viewmodel.post.likes) likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            HStack {
                Text(viewmodel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold)) +
                Text(" \(viewmodel.post.caption)")
                    .font(.system(size: 15))
            }
            .padding(.horizontal, 8)
            Text("\(viewmodel.timestampString)")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding([.leading], 8)
                .padding(.top, 2)
        }
    }
}

// struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell(post: Post)
//    }
// }
