//
//  User.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 26.05.2021.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    let username: String
    let email: String
    var profileImageURL: String
    let fullname: String
    @DocumentID var id: String?
    var stats: UserStats?
    var bio: String?
    var isfollowed: Bool? = false

    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }

}

struct UserStats: Decodable {
    var following: Int
    var followers: Int
    var posts: Int
}
