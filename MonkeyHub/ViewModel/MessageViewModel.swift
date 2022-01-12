//
//  MessageViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 3.07.2021.
//

import SwiftUI
import Firebase

class MessageViewModel: ObservableObject {

    private let user: User
    @Published var messages = [Message]()

    init(toUser: User) {
        self.user = toUser
        fetchMessages()
    }

    func uploadMessage(commentText: String) {

    }

    func fetchMessages() {

    }

}
