//
//  DmConversation.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import FirebaseFirestoreSwift
import Firebase


struct DmConversation: Identifiable, Decodable {
    
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
