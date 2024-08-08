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
    @State var destinationUser: User = .init(username: "", email: "", profileImageURL: "", fullname: "Something went wrong.")

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

                NavigationLink(destination: ProfileView(user: destinationUser)) {
                    Text(viewmodel.post.ownerUsername)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("Black-White"))
                }

                Spacer()

                // MARK: - Delete Button
                if viewmodel.post.ownerUID == AuthViewModel.shared.userSession?.uid {
                    Button(action: {
                        Helper.app.alertMessageWithCompletion(title: "Warning!", message: "Your post will be deleted. Proceed?") { success in
                            if success {
                                PostViewModel().removePost(documentID: viewmodel.post.id!,
                                                           imageURL: viewmodel.post.imageURL ) { error in
                                    guard error == nil else { print("Delete post button error. \(error!.localizedDescription)"); return }
                                    print("post deletion successfull!")

                                }
                            }
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
                ZStack {
                    KFImage(URL(string: viewmodel.post.imageURL))
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 440)
                        .clipped()
                        .addPinchZoom()
                        .onTapGesture(count: 2) {
                            // If didn't like already, like
                            if didLike == false {
                                viewmodel.like()
                                self.likeAnimationHeart = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.likeAnimationHeart = false
                                }
                            } else {
                                // Just show the animation, dont post a like request
                                self.likeAnimationHeart = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.likeAnimationHeart = false
                                }
                            }
                        }

                    if likeAnimationHeart {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100)
                            .clipped()
                            .foregroundColor(.pink)
                    }
                }
            }

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
        .onAppear {
            getUserObject(from: viewmodel.post.ownerUID) { user in
                destinationUser = user!
            }
        }
    }
    func getUserObject(from id: String, completion: @escaping (User?) -> Void) {
        COLLECTION_USERS.document(id).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let userDataFromFirestore = try? snapshot?.data(as: User.self) else {
                completion(nil)
                return
            }
            completion(userDataFromFirestore)
        }
    }
}

// struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell(post: Post)
//    }
// }
