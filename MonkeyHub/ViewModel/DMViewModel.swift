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
    @Published var dmMessages = [DmMessage]()

    init(chatRoom: ChatRoom) {
        self.chatRoom = chatRoom
        fetchDirectMessages()
    }

    func uploadDirectMessages(messageText: String) {

        guard let user = AuthViewModel.shared.currentUserObject else { return }
        guard let dmConversationId = chatRoom.id else { return }

        let data = ["username": user.username,
                    "profileImageURL": user.profileImageURL,
                    "uid": user.id ?? "",
                    "timestamp": Timestamp(date: Date()),
                    "dmCreatorUID": chatRoom.ownerUID,
                    "messageText": messageText] as [String: Any]

        COLLECTION_DIRECTMESSAGES.document(dmConversationId)
            .collection("dmConversation-messages").addDocument(data: data) { error in
            if error != nil {
                Helper.app.alertMessage(title: "Error", message: error!.localizedDescription)
                print("Failed to upload comment. \(error!.localizedDescription)")
            }
        }

    }

    func fetchDirectMessages() {
        guard let dmConversationId = chatRoom.id else { return }

        let query = COLLECTION_DIRECTMESSAGES
            .document(dmConversationId).collection("dmConversation-mesages").order(by: "timestamp",
                                                                                   descending: false)

        query.addSnapshotListener { snapshot, _ in

            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            self.dmMessages.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: DmMessage.self) }))
        }

    }

}
