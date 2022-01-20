//
//  DMViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI
import Firebase

class DMViewModel: ObservableObject {

    private let chatRoom: ChatRoom
    @Published var messages = [Message]()

    init(chatRoom: ChatRoom) {
        self.chatRoom = chatRoom
    }

    func fetchMessages() {
        guard let chatRoomID = chatRoom.id else { return }

        let query = COLLECTION_POSTS.document(chatRoomID).collection("post-comments").order(by: "timestamp",
                                                                                        descending: false)

        query.addSnapshotListener { snapshot, _ in

            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            self.messages.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: Message.self) }))
        }

    }

}
