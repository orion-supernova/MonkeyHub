//
//  Post.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 27.05.2021.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {

    @DocumentID var id: String?
    let ownerUID: String
    let ownerUsername: String
    let ownerImageURL: String
    let caption: String
    var likes: Int
    let imageURL: String
    let timestamp: Timestamp

    var didLike: Bool? = false

}
