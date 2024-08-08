//
//  DmConversation.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import FirebaseFirestore
import Firebase

struct ChatRoom: Identifiable, Codable {

    @DocumentID var id: String?
    let ownersUID: String
    let timestamp: Timestamp
}
